class division_sequence extends base_sequence;
  
  `uvm_object_utils(division_sequence)
  
  function new(string name = "division_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item div_item;
    
    repeat(10) begin
      div_item = ALU_sequence_item::type_id::create("div_item");
      start_item(div_item);
      
      // Selection 0101 for Division
      div_item.selection = 4'b0101;
      div_item.reset = 1'b0;
      
      // Randomize A and B values, ensure B is not zero
      if(!div_item.randomize() with { 
        A inside {[0:255]}; 
        B inside {[1:255]};  // Avoid division by zero
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      finish_item(div_item);
    end
    
    // Test division by zero scenario
    div_item = ALU_sequence_item::type_id::create("div_item");
    start_item(div_item);
    div_item.selection = 4'b0101;
    div_item.reset = 1'b0;
    div_item.A = 8'h0A;  // 10
    div_item.B = 8'h00;  // Divide by zero
    finish_item(div_item);
  endtask
  
endclass
