class ALU_monitor extends uvm_monitor;

//1. Component
`uvm_component_utils(ALU_monitor)

//2. Initializations
virtual ALU_interface vif;
ALU_sequence_item item ;

//3. Port
uvm_analysis_port #(ALU_sequence_item) monitor_port;

//4. Constructor 
function new(string name = "ALU_monitor", uvm_component parent);
    super.new(name, parent);
endfunction : new

//5. Build Phase
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor_port = new("monitor_port", this);
    if(!(uvm_config_db#(virtual ALU_interface)::get(this,"*","vif",vif)))
    begin
            `uvm_error("ALU_monitor", "Failed to get VIF from config DB!")
    end

endfunction : build_phase

//6. Connect Phase
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction : connect_phase

//7. Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        item = ALU_sequence_item::type_id::create("item");
        repeat(2) @(posedge vif.monitor.clock);

            item.reset = vif.reset;
            item.a = vif.a;
            item.b = vif.b;
            item.selection = vif.selection;
            item.result = vif.result;
            item.carry_out = vif.carry_out;

        `uvm_info(get_type_name(), ("Monitor: Sending data to Scoreboard"), UVM_MEDIUM)
        monitor_port.write(item);
    end
  endtask : run_phase

endclass: ALU_monitor