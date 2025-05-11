class or_sequence extends uvm_sequence;

  `uvm_object_utils(or_sequence)

  function new(string name = "or_sequence");
    super.new(name);
  endfunction

  task body();
    ALU_sequence_item item;
    `uvm_info(get_type_name(), "Starting sequence", UVM_MEDIUM)

    // Create an or_item
    item = ALU_sequence::type_id::create("item");

    // Randomize a and b values
    if(!item.randomize() with { 
      a inside {[0:255]}; 
      b inside {[0:255]};
      selection == 4'b0011;
      reset == 1'b0;
    }) begin
      `uvm_error(get_type_name(), "Randomization failed")
    end

    // Start the sequence
    start_item(item);
    finish_item(item);

    `uvm_info(get_type_name(), "Sequence completed", UVM_MEDIUM)
  endtask

endclass