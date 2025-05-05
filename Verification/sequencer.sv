class ALU_sequencer extends uvm_sequencer #(ALU_sequence_item);

//1. UVM component
`uvm_component_utils(ALU_sequencer)

//2. Constructor
  function new(string name = "ALU_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction


//3. Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

endclass: ALU_sequencer