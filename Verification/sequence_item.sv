class ALU_sequence_item extends uvm_sequence_item;

//1.Constructor
  function new(string name = "ALU_sequence_item");
    super.new(name);
  endfunction : new

//2.Initialization
// inputs
  rand logic            reset;
  rand logic    [7:0]   a;
  rand logic    [7:0]   b;
  rand logic    [3:0]   selection;       

//outputs
logic   [7:0]   result;
logic   carry_out;



//3. UVM Registration Macros
  `uvm_object_utils_begin(ALU_sequence_item)
    `uvm_field_int(reset, UVM_ALL_ON)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(selection, UVM_ALL_ON)
    `uvm_field_int(result, UVM_ALL_ON)
    `uvm_field_int(carry_out, UVM_ALL_ON)
  `uvm_object_utils_end

  //4.Constraints (if needed)


endclass : ALU_sequence_item
