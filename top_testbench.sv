`include "uvm_macros.svh"
import uvm_pkg::*;

`include "Design/dut.sv"
`include "Verification/ALU_interface.sv"
`include "Verification/Sequences/addition_sequence.sv"
`include "Verification/Sequences/subtraction_sequence.sv"
`include "Verification/Sequences/division_sequence.sv"
`include "Verification/Sequences/xor_sequence.sv"
`include "Verification/Sequences/and_sequence.sv"
`include "Verification/Sequences/or_sequence.sv"
`include "Verification/Sequences/base_sequence.sv"
`include "Verification/Sequences/right_shift_sequence.sv"
`include "Verification/Sequences/left_shift_sequence.sv"
`include "Verification/Sequences/reset_sequence.sv"




`include "Verification/ALU_sequencer.sv"
`include "Verification/ALU_driver.sv"
`include "Verification/ALU_monitor.sv"
`include "Verification/ALU_agent.sv"
`include "Verification/ALU_scoreboard.sv"
`include "Verification/ALU_env.sv"
`include "Verification/ALU_base_test.sv"
`include "Verification/ALU_operation_test.sv"




module top;


  //Instantiation
  logic clock;

  ALU_interface intf (.clock(clock));

  ALU dut (
    .clock(clock),
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


  //   //Generate Waveforms
  initial begin
    $fsdbDumpfile("debug.fsdb");
    $fsdbDumpvars();
  end



endmodule : top
