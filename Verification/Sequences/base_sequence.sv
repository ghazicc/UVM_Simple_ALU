class base_sequence extends uvm_sequence#(ALU_sequence_item);
  
  `uvm_object_utils(base_sequence)
  
  function new(string name = "base_sequence");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    if (starting_phase != null) 
      starting_phase.raise_objection(this, {"Running sequence '", get_full_name(), "'"});
  endtask
  
  virtual task post_body();
    if (starting_phase != null) 
      starting_phase.drop_objection(this, {"Completed sequence '", get_full_name(), "'"});
  endtask
  
endclass
