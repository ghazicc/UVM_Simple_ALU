class ALU_Test extends BaseTest;
    // 1. Component
    `uvm_component_utils(ALU_Test)

    addition_sequence add_seq;
    string SEQ_NAME;

    // 2. Constructor
    function new(string name = "ALU_Test", uvm_component parent);
        super.new(name, parent);
        add_seq = addition_sequence::type_id::create("add_seq");
    endfunction

    // 3. Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
    endfunction

    // 4. Run Phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        $display("\n");
        add_seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass
