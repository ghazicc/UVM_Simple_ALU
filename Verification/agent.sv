class ALU_agent extends uvm_agent;
    //1. Component
    `uvm_component_utils(ALU_agent)

    //2.Initializations of agent components
    ALU_driver driver;
    ALU_monitor monitor;
    ALU_sequencer sequencer;

    //3. Constuctor
    function new(string name = "ALU_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    //4. Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        driver = ALU_driver::type_id::create("driver", this);
        monitor = ALU_monitor::type_id::create("monitor", this);
        sequencer = ALU_sequencer::type_id::create("sequencer", this);
    endfunction : build_phase

    //5. Connect Phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

    //6. Run Phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask : run_phase

endclass: ALU_agent