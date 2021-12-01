// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

`ifndef SYNTHESIS
`include "prim_assert.sv"

/**
 * OpenTitan Big Number Accelerator (OTBN) Core
 *
 * This module is the top-level of the OTBN processing core.
 */

module otbn_core_model
  import otbn_pkg::*;
  import otbn_model_pkg::*;
  import edn_pkg::*;
  import keymgr_pkg::otbn_key_req_t;
#(
  // Size of the instruction memory, in bytes
  parameter int ImemSizeByte = 4096,
  // Size of the data memory, in bytes
  parameter int DmemSizeByte = 4096,

  // The scope that contains the instruction and data memory (for DPI)
  parameter string MemScope = "",

  // Scope of an RTL OTBN implementation (for DPI). If empty, this is a "standalone" model, which
  // should update DMEM on completion. If not empty, we assume it's the scope for the top-level of a
  // real implementation running alongside and we check DMEM contents on completion.
  parameter string DesignScope = ""
)(
  input  logic               clk_i,
  input  logic               clk_edn_i,
  input  logic               rst_ni,
  input  logic               rst_edn_ni,

  input  logic               start_i, // start the operation

  output err_bits_t          err_bits_o, // updated when STATUS switches to idle

  input  edn_pkg::edn_rsp_t  edn_rnd_i, // EDN response interface for RND
  output logic               edn_rnd_o, // EDN request interface for RND
  input  logic               edn_rnd_cdc_done_i, // RND from EDN is valid (DUT perspective)

  input  edn_pkg::edn_rsp_t  edn_urnd_i, // EDN response interface for URND seed
  output logic               edn_urnd_o, // EDN request interface for URND seed
  input  logic               edn_urnd_cdc_done_i, // URND seed from EDN is valid (DUT perspective)

  output bit [7:0]       status_o,   // STATUS register
  output bit [31:0]      insn_cnt_o, // INSN_CNT register

  input logic            invalidate_imem_i, // Trash contents of IMEM (causing integrity errors)

  input keymgr_pkg::otbn_key_req_t keymgr_key_i,

  output bit             done_rr_o,

  output bit             err_o // something went wrong
);

  localparam int ImemSizeWords = ImemSizeByte / 4;
  localparam int DmemSizeWords = DmemSizeByte / (WLEN / 8);

  // Create and destroy an object through which we can talk to the ISS.
  chandle model_handle;
  initial begin
    model_handle = otbn_model_init(MemScope, DesignScope, ImemSizeWords, DmemSizeWords);
    assert(model_handle != null);
  end
  final begin
    otbn_model_destroy(model_handle);
  end

  // A packed set of bits representing the state of the model. This gets assigned by DPI function
  // calls that need to update both whether we're running and also error flags at the same time. The
  // contents are magic simulation values, so get initialized before reset (to avoid stopping the
  // simulation before it even starts).
  int unsigned model_state = 0;

  // Extract particular bits of the model_state value.
  //
  //   [0]     running:      The ISS is currently running
  //   [1]     check_due:    The ISS just finished but still needs to check results
  //   [2]     failed_step:  Something went wrong when trying to start or step the ISS.
  //   [3]     failed_cmp:   The consistency check at the end of run failed.

  bit failed_cmp, failed_step, check_due, running;
  assign {failed_cmp, failed_step, check_due, running} = model_state[3:0];

  bit [7:0] status_d, status_q;
  bit [31:0] insn_cnt_d, insn_cnt_q;
  bit [31:0] raw_err_bits_d, raw_err_bits_q;
  bit [31:0] stop_pc_d, stop_pc_q;
  bit rnd_req_start_d, rnd_req_start_q;

  bit failed_invalidate_imem;

  bit unused_raw_err_bits;
  logic unused_edn_rsp_fips;

  // EDN RND Request Logic
  logic edn_rnd_req_q, edn_rnd_req_d;

  // Since RND is instantly set inside model we need to wait right until
  // it is also going to be written in RTL (which takes one cycle).
  logic edn_rnd_cdc_done_q;

  // RND Request starts if OTBN Model raises rnd_req_start while we are not
  // finishing up processing RND.
  assign edn_rnd_req_d = ~edn_rnd_cdc_done_q & (edn_rnd_req_q | rnd_req_start_q);

  assign edn_rnd_o = edn_rnd_req_d;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      edn_rnd_req_q <= 1'b0;
      edn_rnd_cdc_done_q <= 1'b0;
    end else begin
      edn_rnd_cdc_done_q <= edn_rnd_cdc_done_i;
      edn_rnd_req_q <= edn_rnd_req_d;
    end
  end

  // EDN URND Seed Request Logic
  logic edn_urnd_req_q, edn_urnd_req_d, start_q;

  // URND Reseeding is only done when we are starting OTBN from fresh.
  assign edn_urnd_req_d = ~edn_urnd_cdc_done_i & (edn_urnd_req_q | start_q);

  assign edn_urnd_o = edn_urnd_req_q;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      edn_urnd_req_q <= 1'b0;
      start_q <= 1'b0;
    end else begin
      edn_urnd_req_q <= edn_urnd_req_d;
      start_q <= start_i;
    end
  end

  // EDN Stepping is done with the EDN clock for also asserting the CDC measures in the design.
  always_ff @(posedge clk_edn_i or negedge rst_edn_ni) begin
    if (!rst_edn_ni) begin
      edn_model_flush(model_handle);
    end else begin
      if (edn_rnd_i.edn_ack) begin
        edn_model_rnd_step(model_handle,
                           edn_rnd_i.edn_bus);
      end
      if (edn_urnd_i.edn_ack) begin
        edn_model_urnd_step(model_handle,
                             edn_urnd_i.edn_bus);
      end
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      otbn_model_reset(model_handle);
      model_state <= 0;
      status_q <= 0;
      insn_cnt_q <= 0;
      rnd_req_start_q <= 0;
      raw_err_bits_q <= 0;
      stop_pc_q <= 0;
      failed_invalidate_imem <= 0;
    end else begin
      if (invalidate_imem_i) begin
        if (otbn_model_invalidate_imem(model_handle) != 0) begin
          failed_invalidate_imem <= 1'b1;
        end
      end
      if (edn_urnd_cdc_done_i) begin
        edn_model_urnd_cdc_done(model_handle);
      end
      if (edn_rnd_cdc_done_i) begin
        edn_model_rnd_cdc_done(model_handle);
      end
      if (start_i | running | check_due) begin
        model_state <= otbn_model_step(model_handle,
                                       start_i,
                                       model_state,
                                       status_d,
                                       insn_cnt_d,
                                       rnd_req_start_d,
                                       raw_err_bits_d,
                                       stop_pc_d);
        status_q <= status_d;
        insn_cnt_q <= insn_cnt_d;
        rnd_req_start_q <= rnd_req_start_d;
        raw_err_bits_q <= raw_err_bits_d;
        stop_pc_q <= stop_pc_d;
      end else begin
        // Make RND Request 0 when we are not running and we're not being told to start.
        rnd_req_start_q <= 1'b0;
      end
    end
  end

  always_ff @(posedge clk_i or posedge rst_ni)
  begin
    if (rst_ni) begin
      if (!$stable(keymgr_key_i) || $rose(rst_ni)) begin
        otbn_model_set_keymgr_value(model_handle, keymgr_key_i.key[0], keymgr_key_i.key[1],
                                    keymgr_key_i.valid);
      end
    end
  end
  // Assertion to ensure that keymgr key valid is never unknown.
  `ASSERT_KNOWN(KeyValidIsKnownChk_A, keymgr_key_i.valid)
  // Assertion to ensure that keymgr key values are never unknown if valid is high.
  `ASSERT_KNOWN_IF(KeyIsKnownChk_A, keymgr_key_i.valid, {keymgr_key_i.key[0], keymgr_key_i.key[1]})
  assign unused_raw_err_bits = ^raw_err_bits_q[31:$bits(err_bits_t)];
  assign unused_edn_rsp_fips = edn_rnd_i.edn_fips & edn_urnd_i.edn_fips;

  assign err_bits_o = raw_err_bits_q[$bits(err_bits_t)-1:0];

  assign status_o = status_q;
  assign insn_cnt_o = insn_cnt_q;

  // If DesignScope is not empty, we have a design to check. Bind a copy of otbn_rf_snooper_if into
  // each register file. The otbn_model_check() function will use these to extract memory contents.
  if (DesignScope != "") begin: g_check_design
    // TODO: This bind is by module, rather than by instance, because I couldn't get the by-instance
    // syntax plus upwards name referencing to work with Verilator. Obviously, this won't work with
    // multiple OTBN instances, so it would be nice to get it right.
    bind otbn_rf_base_ff otbn_rf_snooper_if #(
      .Width           (BaseIntgWidth),
      .Depth           (NGpr),
      .IntegrityEnabled(1)
    ) u_snooper (
      .rf (rf_reg)
    );

    bind otbn_rf_bignum_ff otbn_rf_snooper_if #(
      .Width           (ExtWLEN),
      .Depth           (NWdr),
      .IntegrityEnabled(1)
    ) u_snooper (
      .rf (rf)
    );

    bind otbn_rf_base otbn_stack_snooper_if #(.StackIntgWidth(39), .StackWidth(32), .StackDepth(8))
      u_call_stack_snooper (
        .stack_storage(u_call_stack.stack_storage),
        .stack_wr_ptr_q(u_call_stack.stack_wr_ptr_q)
      );
  end

  assign err_o = failed_step | failed_cmp | failed_invalidate_imem;

  // Derive a "done" signal. This should trigger for a single cycle when OTBN finishes its work.
  // It's analogous to the done_o signal on otbn_core, but this signal is delayed by a single cycle
  // (hence its name is done_r_o).
  bit otbn_model_busy, otbn_model_busy_r;
  assign otbn_model_busy = (status_q != StatusIdle) && (status_q != StatusLocked);
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      otbn_model_busy_r <= 1'b0;
    end else begin
      otbn_model_busy_r <= otbn_model_busy;
    end
  end
  assign done_rr_o = otbn_model_busy_r & ~otbn_model_busy;

  // Make stop_pc available over DPI. This is handy for Verilator simulations (where the top-level
  // is in C++).
  export "DPI-C" function otbn_core_get_stop_pc;
  function automatic int otbn_core_get_stop_pc();
    return stop_pc_q;
  endfunction

endmodule
`endif // SYNTHESIS
