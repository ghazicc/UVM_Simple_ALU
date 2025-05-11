class ALU_scoreboard extends uvm_scoreboard;
  //1. Component
  `uvm_component_utils(ALU_scoreboard)

  //2. Port
  uvm_analysis_imp #(ALU_sequence_item, ALU_scoreboard) scoreboard_port;

  //3. Transactions
  ALU_sequence_item transactions[$];

  //4. Constructor
  function new(string name = "ALU_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //5. Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scoreboard_port = new("scoreboard_port", this);
  endfunction : build_phase

  //6. Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase

  //7. Write 
  function void write(ALU_sequence_item item);
    transactions.push_back(item);
    `uvm_info(get_type_name(), ("Scoreboard: Accept transaction item!"), UVM_MEDIUM)
    item.print();
  endfunction : write

  //8. Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      ALU_sequence_item trans;
      wait ((transactions.size() != 0));
      trans = transactions.pop_front();
      compare(trans);
    end
  endtask : run_phase

  task compare(ALU_sequence_item trans);
    logic [8:0] actual_response;
    logic [8:0] predicted_response;
    logic [7:0] ref_result;
    logic ref_carry_out;
    logic [2:0] shift_amount;
    
    // Capture actual response
    actual_response = {trans.carry_out, trans.result};
    
    // Reference model implementation
    if (trans.reset) begin
        predicted_response = 0;
    end else begin
        shift_amount = trans.b[2:0];
        
        unique case (trans.selection)
            // Addition
            4'b0000: begin
                predicted_response = {1'b0, trans.a} + {1'b0, trans.b};
            end
            
            // Subtraction
            4'b0001: begin
                predicted_response = {1'b0, trans.a} - {1'b0, trans.b};
            end
            
            // Bitwise AND
            4'b0010: begin
                predicted_response = {1'b0, trans.a & trans.b};
            end
            
            // Bitwise OR
            4'b0011: begin
                predicted_response = {1'b0, trans.a | trans.b};
            end
            
            // Bitwise XOR
            4'b0100: begin
                predicted_response = {1'b0, trans.a ^ trans.b};
            end
            
            // Division
            4'b0101: begin
                if (trans.b != 0) begin
                    predicted_response = {1'b0, trans.a / trans.b};
                end else begin
                    predicted_response = {1'b1, 8'b0}; // Division by zero
                end
            end
            
            // Left shift
            4'b0110: begin
            
                predicted_response = {trans.a[7 - shift_amount], trans.a << shift_amount};
            
            end
            
            // Right shift
            4'b0111: begin
                
                predicted_response = {trans.a[shift_amount - 1], trans.a >> shift_amount};
                
            end
            
            // NAND
            4'b1000: begin
                predicted_response = {1'b0, ~(trans.a & trans.b)};
            end
            
            // Default case
            default: begin
                predicted_response = 0;
            end
        endcase
    end

    // Comparison and reporting
    if (actual_response != predicted_response) begin
        `uvm_error(get_type_name(), "✘ TEST FAILED ✘")
        `uvm_info("Scoreboard", 
            $sformatf("Operation: %4b\nA: %0d, B: %0d\nActual: %h\nExpected: %h", 
                     trans.selection, trans.a, trans.b, 
                     actual_response, predicted_response), 
            UVM_NONE)
        `uvm_info(get_type_name(), 
            "┌─────────────────────────────────────────────┐", 
            UVM_NONE)
        `uvm_info(get_type_name(), 
            "│           ✘ Mismatch Detected ✘            │", 
            UVM_NONE)
        `uvm_info(get_type_name(), 
            "└─────────────────────────────────────────────┘", 
            UVM_NONE)
    end else begin
        `uvm_info(get_type_name(), "✓ TEST PASSED ✓", UVM_NONE)
        `uvm_info("Scoreboard", 
            $sformatf("Operation: %4b\nA: %0d, B: %0d\nOutput: %h", 
                     trans.selection, trans.a, trans.b, 
                     actual_response), 
            UVM_LOW)
    end
endtask : compare

  //9. Report Phase
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), "Scoreboard: All transactions processed", UVM_LOW)
  endfunction : report_phase

endclass : ALU_scoreboard



