class bridge_virtual_seqs extends uvm_sequence;
`uvm_object_utils(bridge_virtual_seqs)

ahb_sequencer h_seqrh;
apb_sequencer p_seqrh;
bridge_virtual_sequencer v_seqrh;

extern function new(string name="bridge_virtual_seqs");
extern task body();

endclass

function bridge_virtual_seqs::new(string name="bridge_virtual_seqs");
super.new(name);
endfunction

task  bridge_virtual_seqs::body();
assert($cast(v_seqrh,m_sequencer))
else
`uvm_info("casting","casting is failed",UVM_LOW)
begin
h_seqrh=v_seqrh.h_seqrh;
p_seqrh=v_seqrh.p_seqrh;
end
endtask


class bridge_single_vseqs extends bridge_virtual_seqs;
`uvm_object_utils(bridge_single_vseqs)

ahb_inc4_seqs h_seqsh;
apb_read_seqs p_seqsh;
extern function new(string name="bridge_single_vseqs");
extern task body;
endclass


function bridge_single_vseqs::new(string name="bridge_single_vseqs");
super.new(name);
endfunction


task bridge_single_vseqs::body;
super.body();
h_seqsh=ahb_inc4_seqs::type_id::create("h_seqhs");
p_seqsh=apb_read_seqs::type_id::create("p_seqsh");
begin

h_seqsh.start(h_seqrh);
//p_seqsh.start(p_seqrh);
end
endtask
