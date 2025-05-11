class right_shift_sequence extends base_sequence;
  
  `uvm_object_utils(right_shift_sequence)
  
  function new(string name = "right_shift_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item shift_item;
    
    // Test different shift amounts (0-7)
    for (int i = 0; i <= 7; i++) begin
      shift_item = ALU_sequence_item::type_id::create("shift_item");
      start_item(shift_item);
      
      // Selection 0111 for Right Shift
      shift_item.selection = 4'b0111;
      shift_item.reset = 1'b0;
      shift_item.a = 8'h80;     // Start with 1000 0000
      shift_item.b = i & 8'h07; // Use only lower 3 bits for shift amount (0-7)
      
      // Randomize a and b values
      if(!shift_item.randomize() with { 
        a inside {[0:255]}; 
        b inside {[0:255]};
        selection == 4'b0111;
        reset == 1'b0;
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      finish_item(shift_item);
    end
    
    // Test carry out for right shift
    shift_item = ALU_sequence_item::type_id::create("shift_item");
    start_item(shift_item);
    shift_item.selection = 4'b0111;
    shift_item.reset = 1'b0;
    shift_item.a = 8'h01;  // 0000 0001
    shift_item.b = 8'h01;  // Shift by 1, should result in carry
    finish_item(shift_item);
  endtask
  
endclass
