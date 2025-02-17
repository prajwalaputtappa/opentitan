// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// ------------------- W A R N I N G: A U T O - G E N E R A T E D   C O D E !! -------------------//
// PLEASE DO NOT HAND-EDIT THIS FILE. IT HAS BEEN AUTO-GENERATED WITH THE FOLLOWING COMMAND:
// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0



package clkmgr_pkg;

  typedef enum int {
    HintMainAes = 0,
    HintMainHmac = 1,
    HintMainKmac = 2,
    HintIoDiv4Otbn = 3,
    HintMainOtbn = 4
  } hint_names_e;

  typedef struct packed {
    logic clk_io_div4_powerup;
    logic clk_aon_powerup;
    logic clk_main_powerup;
    logic clk_io_powerup;
    logic clk_usb_powerup;
    logic clk_io_div2_powerup;
    logic clk_aon_infra;
    logic clk_aon_secure;
    logic clk_aon_peri;
    logic clk_aon_timers;
    logic clk_main_aes;
    logic clk_main_hmac;
    logic clk_main_kmac;
    logic clk_main_otbn;
    logic clk_io_div4_otbn;
    logic clk_io_div4_infra;
    logic clk_main_infra;
    logic clk_io_div4_secure;
    logic clk_main_secure;
    logic clk_usb_secure;
    logic clk_io_div4_timers;
    logic clk_proc_main;
    logic clk_io_div4_peri;
    logic clk_io_div2_peri;
    logic clk_io_peri;
    logic clk_usb_peri;

  } clkmgr_out_t;


  typedef struct packed {
    logic [5-1:0] idle;
  } clk_hint_status_t;

  parameter clk_hint_status_t CLK_HINT_STATUS_DEFAULT = '{
    idle: {5{1'b1}}
  };

endpackage // clkmgr_pkg
