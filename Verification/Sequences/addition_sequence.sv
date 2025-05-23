class addition_sequence extends base_sequence;
  
  `uvm_object_utils(addition_sequence)
  
  function new(string name = "addition_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item add_item;
    
    // Random addition tests
    `uvm_info(get_type_name(), "Executing random_add tests", UVM_LOW)
    repeat(3) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      
      
      if(!add_item.randomize() with { 
        a inside {[0:255]}; 
        b inside {[0:255]};
        selection == 4'b0000;  // Ensure it's an addition operation
        reset == 1'b0;        // Ensure reset is off
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      finish_item(add_item);
    end
    
    // Different signs test
    `uvm_info(get_type_name(), "Executing different_signs test", UVM_LOW)
    repeat(3) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Generate a positive number (0-127) for a
      add_item.a = $urandom_range(0, 127);
      // Generate a negative number (128-255) for b
      add_item.b = $urandom_range(128, 255);
      
      finish_item(add_item);
    end
    
    // Same signs test (both positive)
    `uvm_info(get_type_name(), "Executing same_signs test", UVM_LOW)
    repeat(2) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Both positive (0-127)
      add_item.a = $urandom_range(1, 127);
      add_item.b = $urandom_range(1, 127);
      
      finish_item(add_item);
    end
    
    // Two negatives test
    `uvm_info(get_type_name(), "Executing two_negatives test", UVM_LOW)
    repeat(2) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Both negative (128-255)
      add_item.a = $urandom_range(128, 255);
      add_item.b = $urandom_range(128, 255);
      
      finish_item(add_item);
    end
    
    // Max plus max test
    `uvm_info(get_type_name(), "Executing max_plus_max test", UVM_LOW)
    begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Max positive + Max positive (will cause overflow)
      add_item.a = 8'd127;  // Max positive
      add_item.b = 8'd127;  // Max positive
      
      finish_item(add_item);
    end
    
    // Max negative plus max negative test
    `uvm_info(get_type_name(), "Executing max_neg_plus_max_neg test", UVM_LOW)
    begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Max negative + Max negative (will cause overflow)
      add_item.a = 8'd128;  // -128 in two's complement
      add_item.b = 8'd128;  // -128 in two's complement
      
      finish_item(add_item);
    end
    
    // Max plus random test
    `uvm_info(get_type_name(), "Executing max_plus_random test", UVM_LOW)
    repeat(2) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Max positive + random positive
      add_item.a = 8'd127;  // Max positive
      add_item.b = $urandom_range(1, 50);  // Random positive
      
      finish_item(add_item);
    end
    
    // Max negative plus random test
    `uvm_info(get_type_name(), "Executing max_neg_plus_random test", UVM_LOW)
    repeat(2) begin
      add_item = ALU_sequence_item::type_id::create("add_item");
      start_item(add_item);
      
      add_item.selection = 4'b0000;
      add_item.reset = 1'b0;
      
      // Max negative + random negative
      add_item.a = 8'd128;  // -128 in two's complement
      add_item.b = $urandom_range(200, 250);  // Random negative
      
      finish_item(add_item);
    end

  endtask
    
endclass