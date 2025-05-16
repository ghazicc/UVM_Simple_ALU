import uvm_pkg::*;

`include "Design/dut.sv"
`include "Verification/interface.sv"
`include "Verification/sequence_item.sv"
`include "Verification/Sequences/base_sequence.sv"
`include "Verification/Sequences/addition_sequence.sv"
`include "Verification/Sequences/subtraction_sequence.sv"
`include "Verification/Sequences/division_sequence.sv"
`include "Verification/Sequences/xor_sequence.sv"
`include "Verification/Sequences/and_sequence.sv"
`include "Verification/Sequences/or_sequence.sv"
`include "Verification/Sequences/right_shift_sequence.sv"
`include "Verification/Sequences/left_shift_sequence.sv"
`include "Verification/Sequences/reset_sequence.sv"
`include "Verification/Sequences/default_sequence.sv"

`include "Verification/sequencer.sv"
`include "Verification/driver.sv"
`include "Verification/monitor.sv"
`include "Verification/agent.sv"
`include "Verification/scoreboard.sv"
`include "Verification/environment.sv"
`include "Verification/base_test.sv"
`include "Verification/operation_test.sv"

module top;

  //Instantiation
  logic clock;

  ALU_interface intf (.clock(clock));

  ALU dut (
    .clk(clock), // corrected from .clock(clock)
    .reset(intf.reset),
    .A(intf.a),
    .B(intf.b),
    .selection(intf.selection),
    .result(intf.result),
    .carry_out(intf.carry_out)
  );

  //Interface Setting
  initial begin
    uvm_config_db#(virtual ALU_interface)::set(null, "*", "vif", intf);
  end

  //Start The Test
  initial begin
    run_test("ALU_Test");
  end

  //Clock Generation
  initial begin
    clock = 0;
    forever begin
      #5 clock = ~clock;
    end
  end

  //Maximum Simulation Time
  initial begin
    #40000;
    $display("Sorry! Ran out of clock cycles!");
    $finish();
  end

  //Generate Waveforms
  initial begin
    $fsdbDumpfile("debug.fsdb");
    $fsdbDumpvars();
  end

endmodule : top
