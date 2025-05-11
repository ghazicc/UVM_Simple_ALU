class and_sequence extends base_sequence;
  
  `uvm_object_utils(and_sequence)
  
  function new(string name = "and_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item and_item;
    
    repeat(10) begin
      and_item = ALU_sequence_item::type_id::create("and_item");
      start_item(and_item);
      
      // Selection 0010 for AND operation
      and_item.selection = 4'b0010;
      and_item.reset = 1'b0;
      
      // Randomize a and b values
      if(!and_item.randomize() with { 
        a inside {[0:255]}; 
        b inside {[0:255]};
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      finish_item(and_item);
    end
    
    // Test specific cases for AND
    and_item = ALU_sequence_item::type_id::create("and_item");
    start_item(and_item);
    and_item.selection = 4'b0010;
    and_item.reset = 1'b0;
    and_item.a = 8'hFF;  // All 1s
    and_item.b = 8'h0F;  // 0000 1111
    finish_item(and_item);
  endtask
  
endclass
