class reset_sequence extends base_sequence;
  
  `uvm_object_utils(reset_sequence)
  
  function new(string name = "reset_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item reset_item;
    
    reset_item = ALU_sequence_item::type_id::create("reset_item");
    start_item(reset_item);
    
    reset_item.reset = 1'b1;
    reset_item.a = 8'h0;
    reset_item.b = 8'h0;
    reset_item.selection = 4'h0;
    
    finish_item(reset_item);
    
    // De-assert reset after one cycle
    reset_item = ALU_sequence_item::type_id::create("reset_item");
    start_item(reset_item);
    
    reset_item.reset = 1'b0;
    
    finish_item(reset_item);
  endtask
  
endclass
