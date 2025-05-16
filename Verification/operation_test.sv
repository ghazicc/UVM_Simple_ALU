class ALU_Test extends BaseTest;
    // 1. Component
    `uvm_component_utils(ALU_Test)

    addition_sequence add_seq;
    subtraction_sequence sub_seq;
    division_sequence div_seq;
    and_sequence and_seq;
    or_sequence or_seq;
    xor_sequence xor_seq;
    left_shift_sequence lshift_seq;
    right_shift_sequence rshift_seq;
    reset_sequence rst_seq;
    default_sequence default_seq;
    string SEQ_NAME;

    // 2. Constructor
    function new(string name = "ALU_Test", uvm_component parent);
        super.new(name, parent);
        add_seq = addition_sequence::type_id::create("add_seq");
        sub_seq = subtraction_sequence::type_id::create("sub_seq");
        div_seq = division_sequence::type_id::create("div_seq");
        and_seq = and_sequence::type_id::create("and_seq");
        or_seq = or_sequence::type_id::create("or_seq");
        xor_seq = xor_sequence::type_id::create("xor_seq");
        lshift_seq = left_shift_sequence::type_id::create("lshift_seq");
        rshift_seq = right_shift_sequence::type_id::create("rshift_seq");
        rst_seq = reset_sequence::type_id::create("rst_seq");
        default_seq = default_sequence::type_id::create("default_seq");
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
        sub_seq.start(env.agent.sequencer);
        div_seq.start(env.agent.sequencer);
        and_seq.start(env.agent.sequencer);
        or_seq.start(env.agent.sequencer);
        xor_seq.start(env.agent.sequencer);
        lshift_seq.start(env.agent.sequencer);
        rshift_seq.start(env.agent.sequencer);
        rst_seq.start(env.agent.sequencer);
        default_seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass
