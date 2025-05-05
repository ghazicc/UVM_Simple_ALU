class left_shift_sequence extends base_sequence;
  
  `uvm_object_utils(left_shift_sequence)
  
  function new(string name = "left_shift_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    alu_seq_item shift_item;
    
    // Test different shift amounts (0-7)
    for (int i = 0; i <= 7; i++) begin
      shift_item = alu_seq_item::type_id::create("shift_item");
      start_item(shift_item);
      
      // Selection 0110 for Left Shift
      shift_item.selection = 4'b0110;
      shift_item.reset = 1'b0;
      shift_item.A = 8'h01;     // Start with 1
      shift_item.B = i & 8'h07; // Use only lower 3 bits for shift amount (0-7)
      
      finish_item(shift_item);
    end
    
    // Test carry out for left shift
    shift_item = alu_seq_item::type_id::create("shift_item");
    start_item(shift_item);
    shift_item.selection = 4'b0110;
    shift_item.reset = 1'b0;
    shift_item.A = 8'h80;  // 1000 0000
    shift_item.B = 8'h01;  // Shift by 1, should result in carry
    finish_item(shift_item);
  endtask
  
endclass
