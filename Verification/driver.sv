class ALU_driver extends uvm_driver #(ALU_sequence_item);

//1.UVM component
`uvm_component_utils(ALU_driver)

//2. Initialization (vif & seq_item)
virtual ALU_interface vif;
ALU_sequence_item item; 

//3. Constructor
  function new(string name = "ALU_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

//4. Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db#(virtual ALU_interface)::get(this, "*", "vif", vif))) 
            begin
            `uvm_error("ALU_driver", "Failed to get VIF from config DB!")
            end
  endfunction : build_phase


//5. Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase

//6. Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        item = ALU_sequence_item::type_id::create("item");
        seq_item_port.get_next_item(item);
        drive(item);
        seq_item_port.item_done();
    end
  endtask : run_phase

//7. Drive
  task drive(ALU_sequence_item item);
  
    `uvm_info(get_type_name(), $sformatf("Driver: Sending data to DUT\n %s", item.sprint()),UVM_NONE)
    vif.reset <= item.reset;
    vif.a <= item.a ;
    vif.b <= item.b  ;
    vif.selection <= item.selection ;


   repeat(2) @(posedge vif.driver.clock);

  endtask : drive

endclass : ALU_driver