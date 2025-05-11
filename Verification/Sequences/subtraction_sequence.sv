class subtraction_sequence extends base_sequence;
  `uvm_object_utils(subtraction_sequence)

  function new(string name = "subtraction_sequence");
    super.new(name);
  endfunction

  virtual task body();
    ALU_sequence_item sub_item;

    // Random subtraction tests
    repeat(10) begin
      sub_item = ALU_sequence_item::type_id::create("sub_item");
      start_item(sub_item);
    
      if(!sub_item.randomize() with {
        a inside {[0:255]};
        b inside {[0:255]};
        selection == 4'b0001;
        reset == 1'b0;
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      finish_item(sub_item);
    end

    // Test specific cases for subtraction
    // a > b
    sub_item = ALU_sequence_item::type_id::create("sub_item");
    start_item(sub_item);
    sub_item.selection = 4'b0001;
    sub_item.reset = 1'b0;
    sub_item.a = 8'd200;
    sub_item.b = 8'd100;
    finish_item(sub_item);

    // a < b
    sub_item = ALU_sequence_item::type_id::create("sub_item");
    start_item(sub_item);
    sub_item.selection = 4'b0001;
    sub_item.reset = 1'b0;
    sub_item.a = 8'd50;
    sub_item.b = 8'd100;
    finish_item(sub_item);

    // a == b
    sub_item = ALU_sequence_item::type_id::create("sub_item");
    start_item(sub_item);
    sub_item.selection = 4'b0001;
    sub_item.reset = 1'b0;
    sub_item.a = 8'd123;
    sub_item.b = 8'd123;
    finish_item(sub_item);
  endtask

endclass
