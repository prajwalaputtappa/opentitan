// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package entropy_src_reg_pkg;

  // Param list
  parameter int NumAlerts = 2;

  // Address widths within the block
  parameter int BlockAw = 8;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    struct packed {
      logic        q;
    } es_entropy_valid;
    struct packed {
      logic        q;
    } es_health_test_failed;
    struct packed {
      logic        q;
    } es_observe_fifo_ready;
    struct packed {
      logic        q;
    } es_fatal_err;
  } entropy_src_reg2hw_intr_state_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } es_entropy_valid;
    struct packed {
      logic        q;
    } es_health_test_failed;
    struct packed {
      logic        q;
    } es_observe_fifo_ready;
    struct packed {
      logic        q;
    } es_fatal_err;
  } entropy_src_reg2hw_intr_enable_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } es_entropy_valid;
    struct packed {
      logic        q;
      logic        qe;
    } es_health_test_failed;
    struct packed {
      logic        q;
      logic        qe;
    } es_observe_fifo_ready;
    struct packed {
      logic        q;
      logic        qe;
    } es_fatal_err;
  } entropy_src_reg2hw_intr_test_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } recov_alert;
    struct packed {
      logic        q;
      logic        qe;
    } fatal_alert;
  } entropy_src_reg2hw_alert_test_reg_t;

  typedef struct packed {
    struct packed {
      logic [3:0]  q;
    } enable;
    struct packed {
      logic [3:0]  q;
    } entropy_data_reg_enable;
    struct packed {
      logic [3:0]  q;
    } lfsr_enable;
    struct packed {
      logic [3:0]  q;
    } boot_bypass_disable;
    struct packed {
      logic [3:0]  q;
    } health_test_clr;
    struct packed {
      logic [3:0]  q;
    } rng_bit_enable;
    struct packed {
      logic [1:0]  q;
    } rng_bit_sel;
  } entropy_src_reg2hw_conf_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } entropy_src_reg2hw_rate_reg_t;

  typedef struct packed {
    struct packed {
      logic [3:0]  q;
    } es_route;
    struct packed {
      logic [3:0]  q;
    } es_type;
  } entropy_src_reg2hw_entropy_control_reg_t;

  typedef struct packed {
    logic [31:0] q;
    logic        re;
  } entropy_src_reg2hw_entropy_data_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } fips_window;
    struct packed {
      logic [15:0] q;
    } bypass_window;
  } entropy_src_reg2hw_health_test_windows_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_repcnt_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_repcnts_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_adaptp_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_adaptp_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_bucket_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_markov_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_markov_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_extht_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
      logic        qe;
    } fips_thresh;
    struct packed {
      logic [15:0] q;
      logic        qe;
    } bypass_thresh;
  } entropy_src_reg2hw_extht_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } alert_threshold;
    struct packed {
      logic [15:0] q;
    } alert_threshold_inv;
  } entropy_src_reg2hw_alert_threshold_reg_t;

  typedef struct packed {
    struct packed {
      logic [3:0]  q;
    } fw_ov_mode;
    struct packed {
      logic [3:0]  q;
    } fw_ov_entropy_insert;
  } entropy_src_reg2hw_fw_ov_control_reg_t;

  typedef struct packed {
    logic [31:0] q;
    logic        re;
  } entropy_src_reg2hw_fw_ov_rd_data_reg_t;

  typedef struct packed {
    logic [31:0] q;
    logic        qe;
  } entropy_src_reg2hw_fw_ov_wr_data_reg_t;

  typedef struct packed {
    logic [6:0]  q;
  } entropy_src_reg2hw_observe_fifo_thresh_reg_t;

  typedef struct packed {
    logic [3:0]  q;
  } entropy_src_reg2hw_seed_reg_t;

  typedef struct packed {
    logic [4:0]  q;
    logic        qe;
  } entropy_src_reg2hw_err_code_test_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } es_entropy_valid;
    struct packed {
      logic        d;
      logic        de;
    } es_health_test_failed;
    struct packed {
      logic        d;
      logic        de;
    } es_observe_fifo_ready;
    struct packed {
      logic        d;
      logic        de;
    } es_fatal_err;
  } entropy_src_hw2reg_intr_state_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_entropy_data_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_repcnt_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_repcnts_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_adaptp_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_adaptp_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_bucket_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_markov_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_markov_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_extht_hi_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_thresh;
    struct packed {
      logic [15:0] d;
    } bypass_thresh;
  } entropy_src_hw2reg_extht_lo_thresholds_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_repcnt_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_repcnts_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_adaptp_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_adaptp_lo_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_extht_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_extht_lo_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_bucket_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_markov_hi_watermarks_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] d;
    } fips_watermark;
    struct packed {
      logic [15:0] d;
    } bypass_watermark;
  } entropy_src_hw2reg_markov_lo_watermarks_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_repcnt_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_repcnts_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_adaptp_hi_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_adaptp_lo_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_bucket_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_markov_hi_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_markov_lo_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_extht_hi_total_fails_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_extht_lo_total_fails_reg_t;

  typedef struct packed {
    logic [15:0] d;
  } entropy_src_hw2reg_alert_summary_fail_counts_reg_t;

  typedef struct packed {
    struct packed {
      logic [3:0]  d;
    } repcnt_fail_count;
    struct packed {
      logic [3:0]  d;
    } adaptp_hi_fail_count;
    struct packed {
      logic [3:0]  d;
    } adaptp_lo_fail_count;
    struct packed {
      logic [3:0]  d;
    } bucket_fail_count;
    struct packed {
      logic [3:0]  d;
    } markov_hi_fail_count;
    struct packed {
      logic [3:0]  d;
    } markov_lo_fail_count;
    struct packed {
      logic [3:0]  d;
    } repcnts_fail_count;
  } entropy_src_hw2reg_alert_fail_counts_reg_t;

  typedef struct packed {
    struct packed {
      logic [3:0]  d;
    } extht_hi_fail_count;
    struct packed {
      logic [3:0]  d;
    } extht_lo_fail_count;
  } entropy_src_hw2reg_extht_fail_counts_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } entropy_src_hw2reg_fw_ov_rd_data_reg_t;

  typedef struct packed {
    struct packed {
      logic [2:0]  d;
    } entropy_fifo_depth;
    struct packed {
      logic [2:0]  d;
    } sha3_fsm;
    struct packed {
      logic        d;
    } sha3_block_pr;
    struct packed {
      logic        d;
    } sha3_squeezing;
    struct packed {
      logic        d;
    } sha3_absorbed;
    struct packed {
      logic        d;
    } sha3_err;
    struct packed {
      logic        d;
    } main_sm_idle;
    struct packed {
      logic [7:0]  d;
    } main_sm_state;
  } entropy_src_hw2reg_debug_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } es_main_sm_alert;
    struct packed {
      logic        d;
      logic        de;
    } es_bus_cmp_alert;
  } entropy_src_hw2reg_recov_alert_sts_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } sfifo_esrng_err;
    struct packed {
      logic        d;
      logic        de;
    } sfifo_observe_err;
    struct packed {
      logic        d;
      logic        de;
    } sfifo_esfinal_err;
    struct packed {
      logic        d;
      logic        de;
    } es_ack_sm_err;
    struct packed {
      logic        d;
      logic        de;
    } es_main_sm_err;
    struct packed {
      logic        d;
      logic        de;
    } fifo_write_err;
    struct packed {
      logic        d;
      logic        de;
    } fifo_read_err;
    struct packed {
      logic        d;
      logic        de;
    } fifo_state_err;
  } entropy_src_hw2reg_err_code_reg_t;

  // Register -> HW type
  typedef struct packed {
    entropy_src_reg2hw_intr_state_reg_t intr_state; // [563:560]
    entropy_src_reg2hw_intr_enable_reg_t intr_enable; // [559:556]
    entropy_src_reg2hw_intr_test_reg_t intr_test; // [555:548]
    entropy_src_reg2hw_alert_test_reg_t alert_test; // [547:544]
    entropy_src_reg2hw_conf_reg_t conf; // [543:518]
    entropy_src_reg2hw_rate_reg_t rate; // [517:502]
    entropy_src_reg2hw_entropy_control_reg_t entropy_control; // [501:494]
    entropy_src_reg2hw_entropy_data_reg_t entropy_data; // [493:461]
    entropy_src_reg2hw_health_test_windows_reg_t health_test_windows; // [460:429]
    entropy_src_reg2hw_repcnt_thresholds_reg_t repcnt_thresholds; // [428:395]
    entropy_src_reg2hw_repcnts_thresholds_reg_t repcnts_thresholds; // [394:361]
    entropy_src_reg2hw_adaptp_hi_thresholds_reg_t adaptp_hi_thresholds; // [360:327]
    entropy_src_reg2hw_adaptp_lo_thresholds_reg_t adaptp_lo_thresholds; // [326:293]
    entropy_src_reg2hw_bucket_thresholds_reg_t bucket_thresholds; // [292:259]
    entropy_src_reg2hw_markov_hi_thresholds_reg_t markov_hi_thresholds; // [258:225]
    entropy_src_reg2hw_markov_lo_thresholds_reg_t markov_lo_thresholds; // [224:191]
    entropy_src_reg2hw_extht_hi_thresholds_reg_t extht_hi_thresholds; // [190:157]
    entropy_src_reg2hw_extht_lo_thresholds_reg_t extht_lo_thresholds; // [156:123]
    entropy_src_reg2hw_alert_threshold_reg_t alert_threshold; // [122:91]
    entropy_src_reg2hw_fw_ov_control_reg_t fw_ov_control; // [90:83]
    entropy_src_reg2hw_fw_ov_rd_data_reg_t fw_ov_rd_data; // [82:50]
    entropy_src_reg2hw_fw_ov_wr_data_reg_t fw_ov_wr_data; // [49:17]
    entropy_src_reg2hw_observe_fifo_thresh_reg_t observe_fifo_thresh; // [16:10]
    entropy_src_reg2hw_seed_reg_t seed; // [9:6]
    entropy_src_reg2hw_err_code_test_reg_t err_code_test; // [5:0]
  } entropy_src_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    entropy_src_hw2reg_intr_state_reg_t intr_state; // [1026:1019]
    entropy_src_hw2reg_entropy_data_reg_t entropy_data; // [1018:987]
    entropy_src_hw2reg_repcnt_thresholds_reg_t repcnt_thresholds; // [986:955]
    entropy_src_hw2reg_repcnts_thresholds_reg_t repcnts_thresholds; // [954:923]
    entropy_src_hw2reg_adaptp_hi_thresholds_reg_t adaptp_hi_thresholds; // [922:891]
    entropy_src_hw2reg_adaptp_lo_thresholds_reg_t adaptp_lo_thresholds; // [890:859]
    entropy_src_hw2reg_bucket_thresholds_reg_t bucket_thresholds; // [858:827]
    entropy_src_hw2reg_markov_hi_thresholds_reg_t markov_hi_thresholds; // [826:795]
    entropy_src_hw2reg_markov_lo_thresholds_reg_t markov_lo_thresholds; // [794:763]
    entropy_src_hw2reg_extht_hi_thresholds_reg_t extht_hi_thresholds; // [762:731]
    entropy_src_hw2reg_extht_lo_thresholds_reg_t extht_lo_thresholds; // [730:699]
    entropy_src_hw2reg_repcnt_hi_watermarks_reg_t repcnt_hi_watermarks; // [698:667]
    entropy_src_hw2reg_repcnts_hi_watermarks_reg_t repcnts_hi_watermarks; // [666:635]
    entropy_src_hw2reg_adaptp_hi_watermarks_reg_t adaptp_hi_watermarks; // [634:603]
    entropy_src_hw2reg_adaptp_lo_watermarks_reg_t adaptp_lo_watermarks; // [602:571]
    entropy_src_hw2reg_extht_hi_watermarks_reg_t extht_hi_watermarks; // [570:539]
    entropy_src_hw2reg_extht_lo_watermarks_reg_t extht_lo_watermarks; // [538:507]
    entropy_src_hw2reg_bucket_hi_watermarks_reg_t bucket_hi_watermarks; // [506:475]
    entropy_src_hw2reg_markov_hi_watermarks_reg_t markov_hi_watermarks; // [474:443]
    entropy_src_hw2reg_markov_lo_watermarks_reg_t markov_lo_watermarks; // [442:411]
    entropy_src_hw2reg_repcnt_total_fails_reg_t repcnt_total_fails; // [410:379]
    entropy_src_hw2reg_repcnts_total_fails_reg_t repcnts_total_fails; // [378:347]
    entropy_src_hw2reg_adaptp_hi_total_fails_reg_t adaptp_hi_total_fails; // [346:315]
    entropy_src_hw2reg_adaptp_lo_total_fails_reg_t adaptp_lo_total_fails; // [314:283]
    entropy_src_hw2reg_bucket_total_fails_reg_t bucket_total_fails; // [282:251]
    entropy_src_hw2reg_markov_hi_total_fails_reg_t markov_hi_total_fails; // [250:219]
    entropy_src_hw2reg_markov_lo_total_fails_reg_t markov_lo_total_fails; // [218:187]
    entropy_src_hw2reg_extht_hi_total_fails_reg_t extht_hi_total_fails; // [186:155]
    entropy_src_hw2reg_extht_lo_total_fails_reg_t extht_lo_total_fails; // [154:123]
    entropy_src_hw2reg_alert_summary_fail_counts_reg_t alert_summary_fail_counts; // [122:107]
    entropy_src_hw2reg_alert_fail_counts_reg_t alert_fail_counts; // [106:79]
    entropy_src_hw2reg_extht_fail_counts_reg_t extht_fail_counts; // [78:71]
    entropy_src_hw2reg_fw_ov_rd_data_reg_t fw_ov_rd_data; // [70:39]
    entropy_src_hw2reg_debug_status_reg_t debug_status; // [38:20]
    entropy_src_hw2reg_recov_alert_sts_reg_t recov_alert_sts; // [19:16]
    entropy_src_hw2reg_err_code_reg_t err_code; // [15:0]
  } entropy_src_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] ENTROPY_SRC_INTR_STATE_OFFSET = 8'h 0;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_INTR_ENABLE_OFFSET = 8'h 4;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_INTR_TEST_OFFSET = 8'h 8;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ALERT_TEST_OFFSET = 8'h c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REGWEN_OFFSET = 8'h 10;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REV_OFFSET = 8'h 14;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_CONF_OFFSET = 8'h 18;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_RATE_OFFSET = 8'h 1c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ENTROPY_CONTROL_OFFSET = 8'h 20;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ENTROPY_DATA_OFFSET = 8'h 24;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_HEALTH_TEST_WINDOWS_OFFSET = 8'h 28;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNT_THRESHOLDS_OFFSET = 8'h 2c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNTS_THRESHOLDS_OFFSET = 8'h 30;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_HI_THRESHOLDS_OFFSET = 8'h 34;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_LO_THRESHOLDS_OFFSET = 8'h 38;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_BUCKET_THRESHOLDS_OFFSET = 8'h 3c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_HI_THRESHOLDS_OFFSET = 8'h 40;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_LO_THRESHOLDS_OFFSET = 8'h 44;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_HI_THRESHOLDS_OFFSET = 8'h 48;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_LO_THRESHOLDS_OFFSET = 8'h 4c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNT_HI_WATERMARKS_OFFSET = 8'h 50;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNTS_HI_WATERMARKS_OFFSET = 8'h 54;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_HI_WATERMARKS_OFFSET = 8'h 58;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_LO_WATERMARKS_OFFSET = 8'h 5c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_HI_WATERMARKS_OFFSET = 8'h 60;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_LO_WATERMARKS_OFFSET = 8'h 64;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_BUCKET_HI_WATERMARKS_OFFSET = 8'h 68;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_HI_WATERMARKS_OFFSET = 8'h 6c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_LO_WATERMARKS_OFFSET = 8'h 70;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNT_TOTAL_FAILS_OFFSET = 8'h 74;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_REPCNTS_TOTAL_FAILS_OFFSET = 8'h 78;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_HI_TOTAL_FAILS_OFFSET = 8'h 7c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ADAPTP_LO_TOTAL_FAILS_OFFSET = 8'h 80;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_BUCKET_TOTAL_FAILS_OFFSET = 8'h 84;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_HI_TOTAL_FAILS_OFFSET = 8'h 88;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_MARKOV_LO_TOTAL_FAILS_OFFSET = 8'h 8c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_HI_TOTAL_FAILS_OFFSET = 8'h 90;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_LO_TOTAL_FAILS_OFFSET = 8'h 94;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ALERT_THRESHOLD_OFFSET = 8'h 98;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ALERT_SUMMARY_FAIL_COUNTS_OFFSET = 8'h 9c;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ALERT_FAIL_COUNTS_OFFSET = 8'h a0;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_EXTHT_FAIL_COUNTS_OFFSET = 8'h a4;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_FW_OV_CONTROL_OFFSET = 8'h a8;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_FW_OV_RD_DATA_OFFSET = 8'h ac;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_FW_OV_WR_DATA_OFFSET = 8'h b0;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_OBSERVE_FIFO_THRESH_OFFSET = 8'h b4;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_DEBUG_STATUS_OFFSET = 8'h b8;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_SEED_OFFSET = 8'h bc;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_RECOV_ALERT_STS_OFFSET = 8'h c0;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ERR_CODE_OFFSET = 8'h c4;
  parameter logic [BlockAw-1:0] ENTROPY_SRC_ERR_CODE_TEST_OFFSET = 8'h c8;

  // Reset values for hwext registers and their fields
  parameter logic [3:0] ENTROPY_SRC_INTR_TEST_RESVAL = 4'h 0;
  parameter logic [0:0] ENTROPY_SRC_INTR_TEST_ES_ENTROPY_VALID_RESVAL = 1'h 0;
  parameter logic [0:0] ENTROPY_SRC_INTR_TEST_ES_HEALTH_TEST_FAILED_RESVAL = 1'h 0;
  parameter logic [0:0] ENTROPY_SRC_INTR_TEST_ES_OBSERVE_FIFO_READY_RESVAL = 1'h 0;
  parameter logic [0:0] ENTROPY_SRC_INTR_TEST_ES_FATAL_ERR_RESVAL = 1'h 0;
  parameter logic [1:0] ENTROPY_SRC_ALERT_TEST_RESVAL = 2'h 0;
  parameter logic [0:0] ENTROPY_SRC_ALERT_TEST_RECOV_ALERT_RESVAL = 1'h 0;
  parameter logic [0:0] ENTROPY_SRC_ALERT_TEST_FATAL_ALERT_RESVAL = 1'h 0;
  parameter logic [31:0] ENTROPY_SRC_ENTROPY_DATA_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_REPCNT_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_REPCNT_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_REPCNT_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_REPCNTS_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_REPCNTS_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_REPCNTS_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_HI_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_HI_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_HI_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_LO_THRESHOLDS_RESVAL = 32'h 0;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_LO_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h 0;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_LO_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h 0;
  parameter logic [31:0] ENTROPY_SRC_BUCKET_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_BUCKET_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_BUCKET_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_HI_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_HI_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_HI_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_LO_THRESHOLDS_RESVAL = 32'h 0;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_LO_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h 0;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_LO_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h 0;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_HI_THRESHOLDS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_HI_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_HI_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_LO_THRESHOLDS_RESVAL = 32'h 0;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_LO_THRESHOLDS_FIPS_THRESH_RESVAL = 16'h 0;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_LO_THRESHOLDS_BYPASS_THRESH_RESVAL = 16'h 0;
  parameter logic [31:0] ENTROPY_SRC_REPCNT_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_REPCNTS_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_LO_WATERMARKS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_LO_WATERMARKS_FIPS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_ADAPTP_LO_WATERMARKS_BYPASS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_LO_WATERMARKS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_LO_WATERMARKS_FIPS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_EXTHT_LO_WATERMARKS_BYPASS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_BUCKET_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_HI_WATERMARKS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_LO_WATERMARKS_RESVAL = 32'h ffffffff;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_LO_WATERMARKS_FIPS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [15:0] ENTROPY_SRC_MARKOV_LO_WATERMARKS_BYPASS_WATERMARK_RESVAL = 16'h ffff;
  parameter logic [31:0] ENTROPY_SRC_REPCNT_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_REPCNTS_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_HI_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_ADAPTP_LO_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_BUCKET_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_HI_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_MARKOV_LO_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_HI_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_EXTHT_LO_TOTAL_FAILS_RESVAL = 32'h 0;
  parameter logic [15:0] ENTROPY_SRC_ALERT_SUMMARY_FAIL_COUNTS_RESVAL = 16'h 0;
  parameter logic [31:0] ENTROPY_SRC_ALERT_FAIL_COUNTS_RESVAL = 32'h 0;
  parameter logic [7:0] ENTROPY_SRC_EXTHT_FAIL_COUNTS_RESVAL = 8'h 0;
  parameter logic [31:0] ENTROPY_SRC_FW_OV_RD_DATA_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_FW_OV_WR_DATA_RESVAL = 32'h 0;
  parameter logic [31:0] ENTROPY_SRC_DEBUG_STATUS_RESVAL = 32'h 0;

  // Register index
  typedef enum int {
    ENTROPY_SRC_INTR_STATE,
    ENTROPY_SRC_INTR_ENABLE,
    ENTROPY_SRC_INTR_TEST,
    ENTROPY_SRC_ALERT_TEST,
    ENTROPY_SRC_REGWEN,
    ENTROPY_SRC_REV,
    ENTROPY_SRC_CONF,
    ENTROPY_SRC_RATE,
    ENTROPY_SRC_ENTROPY_CONTROL,
    ENTROPY_SRC_ENTROPY_DATA,
    ENTROPY_SRC_HEALTH_TEST_WINDOWS,
    ENTROPY_SRC_REPCNT_THRESHOLDS,
    ENTROPY_SRC_REPCNTS_THRESHOLDS,
    ENTROPY_SRC_ADAPTP_HI_THRESHOLDS,
    ENTROPY_SRC_ADAPTP_LO_THRESHOLDS,
    ENTROPY_SRC_BUCKET_THRESHOLDS,
    ENTROPY_SRC_MARKOV_HI_THRESHOLDS,
    ENTROPY_SRC_MARKOV_LO_THRESHOLDS,
    ENTROPY_SRC_EXTHT_HI_THRESHOLDS,
    ENTROPY_SRC_EXTHT_LO_THRESHOLDS,
    ENTROPY_SRC_REPCNT_HI_WATERMARKS,
    ENTROPY_SRC_REPCNTS_HI_WATERMARKS,
    ENTROPY_SRC_ADAPTP_HI_WATERMARKS,
    ENTROPY_SRC_ADAPTP_LO_WATERMARKS,
    ENTROPY_SRC_EXTHT_HI_WATERMARKS,
    ENTROPY_SRC_EXTHT_LO_WATERMARKS,
    ENTROPY_SRC_BUCKET_HI_WATERMARKS,
    ENTROPY_SRC_MARKOV_HI_WATERMARKS,
    ENTROPY_SRC_MARKOV_LO_WATERMARKS,
    ENTROPY_SRC_REPCNT_TOTAL_FAILS,
    ENTROPY_SRC_REPCNTS_TOTAL_FAILS,
    ENTROPY_SRC_ADAPTP_HI_TOTAL_FAILS,
    ENTROPY_SRC_ADAPTP_LO_TOTAL_FAILS,
    ENTROPY_SRC_BUCKET_TOTAL_FAILS,
    ENTROPY_SRC_MARKOV_HI_TOTAL_FAILS,
    ENTROPY_SRC_MARKOV_LO_TOTAL_FAILS,
    ENTROPY_SRC_EXTHT_HI_TOTAL_FAILS,
    ENTROPY_SRC_EXTHT_LO_TOTAL_FAILS,
    ENTROPY_SRC_ALERT_THRESHOLD,
    ENTROPY_SRC_ALERT_SUMMARY_FAIL_COUNTS,
    ENTROPY_SRC_ALERT_FAIL_COUNTS,
    ENTROPY_SRC_EXTHT_FAIL_COUNTS,
    ENTROPY_SRC_FW_OV_CONTROL,
    ENTROPY_SRC_FW_OV_RD_DATA,
    ENTROPY_SRC_FW_OV_WR_DATA,
    ENTROPY_SRC_OBSERVE_FIFO_THRESH,
    ENTROPY_SRC_DEBUG_STATUS,
    ENTROPY_SRC_SEED,
    ENTROPY_SRC_RECOV_ALERT_STS,
    ENTROPY_SRC_ERR_CODE,
    ENTROPY_SRC_ERR_CODE_TEST
  } entropy_src_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] ENTROPY_SRC_PERMIT [51] = '{
    4'b 0001, // index[ 0] ENTROPY_SRC_INTR_STATE
    4'b 0001, // index[ 1] ENTROPY_SRC_INTR_ENABLE
    4'b 0001, // index[ 2] ENTROPY_SRC_INTR_TEST
    4'b 0001, // index[ 3] ENTROPY_SRC_ALERT_TEST
    4'b 0001, // index[ 4] ENTROPY_SRC_REGWEN
    4'b 0111, // index[ 5] ENTROPY_SRC_REV
    4'b 1111, // index[ 6] ENTROPY_SRC_CONF
    4'b 0011, // index[ 7] ENTROPY_SRC_RATE
    4'b 0001, // index[ 8] ENTROPY_SRC_ENTROPY_CONTROL
    4'b 1111, // index[ 9] ENTROPY_SRC_ENTROPY_DATA
    4'b 1111, // index[10] ENTROPY_SRC_HEALTH_TEST_WINDOWS
    4'b 1111, // index[11] ENTROPY_SRC_REPCNT_THRESHOLDS
    4'b 1111, // index[12] ENTROPY_SRC_REPCNTS_THRESHOLDS
    4'b 1111, // index[13] ENTROPY_SRC_ADAPTP_HI_THRESHOLDS
    4'b 1111, // index[14] ENTROPY_SRC_ADAPTP_LO_THRESHOLDS
    4'b 1111, // index[15] ENTROPY_SRC_BUCKET_THRESHOLDS
    4'b 1111, // index[16] ENTROPY_SRC_MARKOV_HI_THRESHOLDS
    4'b 1111, // index[17] ENTROPY_SRC_MARKOV_LO_THRESHOLDS
    4'b 1111, // index[18] ENTROPY_SRC_EXTHT_HI_THRESHOLDS
    4'b 1111, // index[19] ENTROPY_SRC_EXTHT_LO_THRESHOLDS
    4'b 1111, // index[20] ENTROPY_SRC_REPCNT_HI_WATERMARKS
    4'b 1111, // index[21] ENTROPY_SRC_REPCNTS_HI_WATERMARKS
    4'b 1111, // index[22] ENTROPY_SRC_ADAPTP_HI_WATERMARKS
    4'b 1111, // index[23] ENTROPY_SRC_ADAPTP_LO_WATERMARKS
    4'b 1111, // index[24] ENTROPY_SRC_EXTHT_HI_WATERMARKS
    4'b 1111, // index[25] ENTROPY_SRC_EXTHT_LO_WATERMARKS
    4'b 1111, // index[26] ENTROPY_SRC_BUCKET_HI_WATERMARKS
    4'b 1111, // index[27] ENTROPY_SRC_MARKOV_HI_WATERMARKS
    4'b 1111, // index[28] ENTROPY_SRC_MARKOV_LO_WATERMARKS
    4'b 1111, // index[29] ENTROPY_SRC_REPCNT_TOTAL_FAILS
    4'b 1111, // index[30] ENTROPY_SRC_REPCNTS_TOTAL_FAILS
    4'b 1111, // index[31] ENTROPY_SRC_ADAPTP_HI_TOTAL_FAILS
    4'b 1111, // index[32] ENTROPY_SRC_ADAPTP_LO_TOTAL_FAILS
    4'b 1111, // index[33] ENTROPY_SRC_BUCKET_TOTAL_FAILS
    4'b 1111, // index[34] ENTROPY_SRC_MARKOV_HI_TOTAL_FAILS
    4'b 1111, // index[35] ENTROPY_SRC_MARKOV_LO_TOTAL_FAILS
    4'b 1111, // index[36] ENTROPY_SRC_EXTHT_HI_TOTAL_FAILS
    4'b 1111, // index[37] ENTROPY_SRC_EXTHT_LO_TOTAL_FAILS
    4'b 1111, // index[38] ENTROPY_SRC_ALERT_THRESHOLD
    4'b 0011, // index[39] ENTROPY_SRC_ALERT_SUMMARY_FAIL_COUNTS
    4'b 1111, // index[40] ENTROPY_SRC_ALERT_FAIL_COUNTS
    4'b 0001, // index[41] ENTROPY_SRC_EXTHT_FAIL_COUNTS
    4'b 0001, // index[42] ENTROPY_SRC_FW_OV_CONTROL
    4'b 1111, // index[43] ENTROPY_SRC_FW_OV_RD_DATA
    4'b 1111, // index[44] ENTROPY_SRC_FW_OV_WR_DATA
    4'b 0001, // index[45] ENTROPY_SRC_OBSERVE_FIFO_THRESH
    4'b 1111, // index[46] ENTROPY_SRC_DEBUG_STATUS
    4'b 0001, // index[47] ENTROPY_SRC_SEED
    4'b 0011, // index[48] ENTROPY_SRC_RECOV_ALERT_STS
    4'b 1111, // index[49] ENTROPY_SRC_ERR_CODE
    4'b 0001  // index[50] ENTROPY_SRC_ERR_CODE_TEST
  };

endpackage

