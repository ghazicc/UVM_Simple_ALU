`include "uvm_macros.svh"
import uvm_pkg::*;

`include "Design/adder.sv"
`include "TestBench/Adder_interface.sv"
`include "TestBench/Adder_sequence_item.sv"
`include "TestBench/Sequences/RESET_Sequence.sv"
`include "TestBench/Sequences/Random_Sequence.sv"

`include "TestBench/Adder_sequencer.sv"
`include "TestBench/Adder_driver.sv"
`include "TestBench/Adder_monitor.sv"
`include "TestBench/Adder_agent.sv"
`include "TestBench/Adder_scoreboard.sv"
`include "TestBench/Adder_env.sv"
`include "TestBench/Adder_base_test.sv"
`include "TestBench/Adder_operation_test.sv"




module top;


  //Instantiation
  logic clock;

  Adder_interface intf (.clock(clock));

  adder dut (
      .clk(intf.clock),
      .reset(intf.reset),
      .a(intf.a),
      .b(intf.b),
      .valid(intf.valid),
      .c(intf.c)
  );



  //Interface Setting
  initial begin
    uvm_config_db#(virtual Adder_interface)::set(null, "*", "vif", intf);
  end


  //Start The Test
  initial begin
    run_test("Adder_Test");
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
