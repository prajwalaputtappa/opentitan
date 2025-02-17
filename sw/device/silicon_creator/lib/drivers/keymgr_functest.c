// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <stdbool.h>
#include <stdint.h>

#include "sw/device/lib/arch/device.h"
#include "sw/device/lib/base/memory.h"
#include "sw/device/lib/dif/dif_aon_timer.h"
#include "sw/device/lib/dif/dif_kmac.h"
#include "sw/device/lib/dif/dif_otp_ctrl.h"
#include "sw/device/lib/dif/dif_pwrmgr.h"
#include "sw/device/lib/flash_ctrl.h"
#include "sw/device/lib/runtime/hart.h"
#include "sw/device/lib/runtime/log.h"
#include "sw/device/lib/runtime/print.h"
#include "sw/device/lib/testing/check.h"
#include "sw/device/silicon_creator/lib/base/sec_mmio.h"
#include "sw/device/silicon_creator/lib/drivers/keymgr.h"
#include "sw/device/silicon_creator/lib/drivers/lifecycle.h"
#include "sw/device/silicon_creator/lib/error.h"
#include "sw/device/silicon_creator/lib/keymgr_binding_value.h"
#include "sw/device/silicon_creator/lib/test_main.h"

#include "hw/top_earlgrey/sw/autogen/top_earlgrey.h"
#include "keymgr_regs.h"

#define ASSERT_OK(expr_)                        \
  do {                                          \
    rom_error_t local_error_ = expr_;           \
    if (local_error_ != kErrorOk) {             \
      LOG_ERROR("Error at line: %d", __LINE__); \
      return local_error_;                      \
    }                                           \
  } while (0)

#define ASSERT_EQZ(x) CHECK((x) == 0)

enum {
  /** Creator Secret flash info page ID. */
  kFlashInfoPageIdCreatorSecret = 1,

  /** Owner Secret flash info page ID. */
  kFlashInfoPageIdOwnerSecret = 2,

  /** Key manager secret word size. */
  kSecretWordSize = 16,
};

/**
 * Software binding value associated with the ROM_EXT. Programmed by
 * mask ROM.
 */
const keymgr_binding_value_t kBindingValueRomExt = {
    .data = {0xdc96c23d, 0xaf36e268, 0xcb68ff71, 0xe92f76e2, 0xb8a8379d,
             0x426dc745, 0x19f5cff7, 0x4ec9c6d6},
};

/**
 * Software binding value associated with BL0. Programmed by ROM_EXT.
 */
const keymgr_binding_value_t kBindingValueBl0 = {
    .data = {0xe4987b39, 0x3f83d390, 0xc2f3bbaf, 0x3195dbfa, 0x23fb480c,
             0xb012ae5e, 0xf1394d28, 0x1940ceeb},
};

/**
 * Key manager Creator Secret stored in info flash page.
 */
const uint32_t kCreatorSecret[kSecretWordSize] = {
    0x4e919d54, 0x322288d8, 0x4bd127c7, 0x9f89bc56, 0xb4fb0fdf, 0x1ca1567b,
    0x13a0e876, 0xa6521d8f, 0xbebf6301, 0xd10879a1, 0x69797afb, 0x5f295405,
    0x444a8511, 0xe7bb2fa5, 0xd570c0a3, 0xf15f82e5,
};

/**
 * Key manager Owner Secret stored in info flash page.
 */
const uint32_t kOwnerSecret[kSecretWordSize] = {
    0xf15f82e5, 0xd570c0a3, 0xe7bb2fa5, 0x444a8511, 0x5f295405, 0x69797afb,
    0xd10879a1, 0xbebf6301, 0xa6521d8f, 0x13a0e876, 0x1ca1567b, 0xb4fb0fdf,
    0x9f89bc56, 0x4bd127c7, 0x322288d8, 0x4e919d54,
};

/** ROM_EXT key manager maximum version. */
const uint32_t kMaxVerRomExt = 1;

/** BL0 key manager maximum version. */
const uint32_t kMaxVerBl0 = 2;

const test_config_t kTestConfig;

/**
 * Writes `size` words of `data` into flash info page.
 *
 * @param page_id Info page ID to write to.
 * @param data Data to write.
 * @param size Number of 4B words to write from `data` buffer.
 */
static void write_info_page(uint32_t page_id, const uint32_t *data,
                            size_t size) {
  mp_region_t info_region = {.num = page_id,
                             .base = 0x0,  // only used to calculate bank id.
                             .size = 0x1,  // unused for info pages.
                             .part = kInfoPartition,
                             .rd_en = true,
                             .prog_en = true,
                             .erase_en = true,
                             .scramble_en = false};
  flash_cfg_region(&info_region);

  uint32_t address = FLASH_MEM_BASE_ADDR + page_id * flash_get_page_size();

  ASSERT_EQZ(flash_page_erase(address, kInfoPartition));
  ASSERT_EQZ(flash_write(address, kInfoPartition, data, size));

  for (size_t i = 0; i < size; ++i) {
    uint32_t got_data;
    ASSERT_EQZ(flash_read(address + i * sizeof(uint32_t), kInfoPartition,
                          /*size=*/1, &got_data));
    CHECK(got_data == data[i]);
  }
  info_region.rd_en = false;
  info_region.prog_en = false;
  info_region.erase_en = false;
  flash_cfg_region(&info_region);
}

static void init_flash(void) {
  // setup default access for data partition
  flash_default_region_access(/*rd_en=*/true, /*prog_en=*/true,
                              /*erase_en=*/true);
  // Initialize flash secrets.
  write_info_page(kFlashInfoPageIdCreatorSecret, kCreatorSecret,
                  ARRAYSIZE(kCreatorSecret));
  write_info_page(kFlashInfoPageIdOwnerSecret, kOwnerSecret,
                  ARRAYSIZE(kOwnerSecret));
}

/** Key manager configuration steps performed in mask ROM. */
rom_error_t keymgr_rom_test(void) {
  ASSERT_OK(keymgr_check_state(kKeymgrStateReset));
  keymgr_set_next_stage_inputs(&kBindingValueRomExt, kMaxVerRomExt);
  return kErrorOk;
}

/** Key manager configuration steps performed in ROM_EXT. */
rom_error_t keymgr_rom_ext_test(void) {
  ASSERT_OK(keymgr_check_state(kKeymgrStateReset));

  const uint16_t kEntropyReseedInterval = 0x1234;
  ASSERT_OK(keymgr_init(kEntropyReseedInterval));
  keymgr_advance_state();
  ASSERT_OK(keymgr_check_state(kKeymgrStateInit));

  // FIXME: Check `kBindingValueRomExt` before advancing state.
  keymgr_advance_state();
  ASSERT_OK(keymgr_check_state(kKeymgrStateCreatorRootKey));

  keymgr_set_next_stage_inputs(&kBindingValueBl0, kMaxVerBl0);

  // FIXME: Check `kBindingValueBl0` before advancing state.
  keymgr_advance_state();
  ASSERT_OK(keymgr_check_state(kKeymgrStateOwnerIntermediateKey));
  return kErrorOk;
}

static const dif_pwrmgr_wakeup_reason_t kWakeUpReasonPor = {
    .types = 0,
    .request_sources = 0,
};

/** Check wakeup reason to determine what to do during the test */
static bool compare_wakeup_reasons(const dif_pwrmgr_wakeup_reason_t *lhs,
                                   const dif_pwrmgr_wakeup_reason_t *rhs) {
  return lhs->types == rhs->types &&
         lhs->request_sources == rhs->request_sources;
}

static void aon_timer_wakeup_config(dif_aon_timer_t *aon_timer,
                                    uint32_t wakeup_threshold) {
  // Make sure that wake-up timer is stopped.
  CHECK(dif_aon_timer_wakeup_stop(aon_timer) == kDifAonTimerOk);

  // Make sure the wake-up IRQ is cleared to avoid false positive.
  CHECK(dif_aon_timer_irq_acknowledge(
            aon_timer, kDifAonTimerIrqWakeupThreshold) == kDifAonTimerOk);

  bool is_pending;
  CHECK(dif_aon_timer_irq_is_pending(aon_timer, kDifAonTimerIrqWakeupThreshold,
                                     &is_pending) == kDifAonTimerOk);
  CHECK(!is_pending);

  CHECK(dif_aon_timer_wakeup_start(aon_timer, wakeup_threshold, 0) ==
        kDifAonTimerOk);
}

/**
 * Busy-wait until the DAI is done with whatever operation it is doing.
 */
static dif_otp_ctrl_t otp;

static void wait_for_dai(void) {
  while (true) {
    dif_otp_ctrl_status_t status;
    CHECK(dif_otp_ctrl_get_status(&otp, &status) == kDifOtpCtrlOk);
    if (bitfield_bit32_read(status.codes, kDifOtpCtrlStatusCodeDaiIdle)) {
      return;
    }
    LOG_INFO("Waiting for DAI...");
  }
}

/**
 * Lock otp secret 2 partition so that on reboot flash seeds can be
 * automatically loaded
 */
static void lock_otp_secret_partition2(void) {
  // initialize otp
  mmio_region_t otp_reg_core =
      mmio_region_from_addr(TOP_EARLGREY_OTP_CTRL_CORE_BASE_ADDR);
  mmio_region_t otp_reg_prim =
      mmio_region_from_addr(TOP_EARLGREY_OTP_CTRL_PRIM_BASE_ADDR);
  CHECK(
      dif_otp_ctrl_init((dif_otp_ctrl_params_t){.base_addr_core = otp_reg_core,
                                                .base_addr_prim = otp_reg_prim},
                        &otp) == kDifOtpCtrlOk);

  CHECK(dif_otp_ctrl_dai_digest(&otp, kDifOtpCtrlPartitionSecret2, 0) ==
        kDifOtpCtrlDaiOk);

  wait_for_dai();
}

/** Place kmac into sideload mode for correct keymgr operation */
static void init_kmac_for_keymgr(void) {
  dif_kmac_t kmac;
  CHECK(dif_kmac_init((dif_kmac_params_t){.base_addr = mmio_region_from_addr(
                                              TOP_EARLGREY_KMAC_BASE_ADDR)},
                      &kmac) == kDifKmacOk);

  // Configure KMAC hardware using software entropy.
  dif_kmac_config_t config = (dif_kmac_config_t){
      .sideload = true,
  };
  CHECK(dif_kmac_configure(&kmac, config) == kDifKmacOk);
}

/** Soft reboot device */
static void soft_reboot(dif_pwrmgr_t *pwrmgr, dif_aon_timer_t *aon_timer) {
  aon_timer_wakeup_config(aon_timer, 1);

  // Place device into low power and immediately wake
  dif_pwrmgr_domain_config_t config;
  config = kDifPwrmgrDomainOptionUsbClockInActivePower;

  CHECK(dif_pwrmgr_set_request_sources(pwrmgr, kDifPwrmgrReqTypeWakeup,
                                       kDifPwrmgrWakeupRequestSourceFive) ==
        kDifPwrmgrConfigOk);
  CHECK(dif_pwrmgr_set_domain_config(pwrmgr, config) == kDifPwrmgrConfigOk);
  CHECK(dif_pwrmgr_low_power_set_enabled(pwrmgr, kDifPwrmgrToggleEnabled) ==
        kDifPwrmgrConfigOk);

  // Enter low power mode.
  LOG_INFO("Entering low power");
  wait_for_interrupt();
}

bool test_main(void) {
  rom_error_t result = kErrorOk;

  // This test is expected to run in DEV, PROD or PROD_END states.
  lifecycle_state_t lc_state = lifecycle_state_get();
  LOG_INFO("lifecycle state: %s", lifecycle_state_name[lc_state]);

  // Initialize pwrmgr
  dif_pwrmgr_t pwrmgr;
  CHECK(dif_pwrmgr_init(
            (dif_pwrmgr_params_t){
                .base_addr =
                    mmio_region_from_addr(TOP_EARLGREY_PWRMGR_AON_BASE_ADDR),
            },
            &pwrmgr) == kDifPwrmgrOk);

  // Initialize aon_timer
  dif_aon_timer_t aon_timer;
  dif_aon_timer_params_t params = {
      .base_addr = mmio_region_from_addr(TOP_EARLGREY_AON_TIMER_AON_BASE_ADDR),
  };
  CHECK(dif_aon_timer_init(params, &aon_timer) == kDifAonTimerOk);

  // Get wakeup reason
  dif_pwrmgr_wakeup_reason_t wakeup_reason;
  CHECK(dif_pwrmgr_wakeup_reason_get(&pwrmgr, &wakeup_reason) == kDifPwrmgrOk);

  if (compare_wakeup_reasons(&wakeup_reason, &kWakeUpReasonPor)) {
    LOG_INFO("Powered up for the first time, program flash");

    // Initialize flash
    init_flash();

    // Lock otp secret partition
    lock_otp_secret_partition2();

    // reboot device
    soft_reboot(&pwrmgr, &aon_timer);

  } else {
    LOG_INFO("Powered up for the second time, actuate keymgr");

    // Initialize kmac for key manager
    init_kmac_for_keymgr();

    EXECUTE_TEST(result, keymgr_rom_test);
    EXECUTE_TEST(result, keymgr_rom_ext_test);
    return result == kErrorOk;
  }

  return false;
}
