class default_sequence extends base_sequence;
  
  `uvm_object_utils(default_sequence)
  
  function new(string name = "default_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    ALU_sequence_item default_item;
    
    // Default sequence for ALU operations
    `uvm_info(get_type_name(), "Executing default tests", UVM_LOW)
    repeat(5) begin
      default_item = ALU_sequence_item::type_id::create("default_item");
      start_item(default_item);
      
    
      // Randomize a and b values
      if(!default_item.randomize() with { 
        a inside {[0:255]}; 
        b inside {[0:255]};
        selection inside {[8:15]};
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      
      default_item.reset = 1'b0; // Ensure reset is off

      finish_item(default_item);
    end
  endtask
endclass