// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#ifndef OPENTITAN_SW_DEVICE_LIB_DIF_DIF_BASE_H_
#define OPENTITAN_SW_DEVICE_LIB_DIF_DIF_BASE_H_

/**
 * @file
 * @brief Shared macros and headers for DIFs.
 */

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/**
 * The result of a DIF operation.
 *
 * NOTE: additional result values can be defined in the manually-implemented
 * header by creating an additional *_result_t enum type. See the Lifecycle
 * Controller DIF for how this may be implemented.
 */
typedef enum dif_result {
  /**
   * Indicates that the operation succeeded.
   */
  kDifOk = 0,
  /**
   * Indicates some unspecified failure.
   */
  kDifError = 1,
  /**
   * Indicates that some parameter passed into a function failed a
   * precondition.
   *
   * When this value is returned, no hardware operations occurred.
   */
  kDifBadArg = 2,
  /**
   * The operation failed because writes to a required register are
   * disabled.
   */
  kDifLocked = 3,
} dif_result_t;

/**
 * A toggle state: enabled, or disabled.
 *
 * This enum may be used instead of a `bool` when describing an enabled/disabled
 * state.
 */
typedef enum dif_toggle {
  /**
   * The "enabled" state.
   */
  kDifToggleEnabled,
  /**
   * The "disabled" state.
   */
  kDifToggleDisabled,
} dif_toggle_t;

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // OPENTITAN_SW_DEVICE_LIB_DIF_DIF_BASE_H_
