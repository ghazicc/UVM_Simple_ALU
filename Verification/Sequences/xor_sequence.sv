class xor_sequence extends base_sequence;
  
  `uvm_object_utils(xor_sequence)
  
  function new(string name = "xor_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item xor_item;
    
    repeat(10) begin
      xor_item = ALU_sequence_item::type_id::create("xor_item");
      start_item(xor_item);
      
      // Selection 0100 for XOR operation
      xor_item.selection = 4'b0100;
      xor_item.reset = 1'b0;
      
      // Randomize a and b values
      if(!xor_item.randomize() with { 
        a inside {[0:255]}; 
        b inside {[0:255]};
        selection == 4'b0100;
        reset == 1'b0;
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      finish_item(xor_item);
    end
    
    // Test specific cases for XOR
    xor_item = ALU_sequence_item::type_id::create("xor_item");
    start_item(xor_item);
    xor_item.selection = 4'b0100;
    xor_item.reset = 1'b0;
    xor_item.a = 8'hF0;  // 1111 0000
    xor_item.b = 8'h0F;  // 0000 1111
    finish_item(xor_item);
  endtask
  
endclass
