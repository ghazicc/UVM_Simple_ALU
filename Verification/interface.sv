interface ALU_interface (input logic clock);
 
logic reset;
//other inputs
logic   [7:0]  a;
logic   [7:0]  b;
logic   [3:0] selection;
        
//other outputs
logic   [7:0]   result;
logic   carry_out;

  clocking drv @(posedge clock);
  default input #2ns output #2ns;
    output reset;
    output a;
    output b;
    output selection;         
  endclocking

  clocking mon @(posedge clock);
  default input #2ns output #2ns;
    input reset;
    input a;
    input b;
    input selection;
    input result;
    input carry_out    
  endclocking

  modport driver(clocking drv, input clock);
  modport monitor(clocking mon, input clock);


endinterface : ALU_interface
