class bridge_virtual_sequencer extends uvm_sequencer;
`uvm_component_utils(bridge_virtual_sequencer)
ahb_sequencer h_seqrh;
apb_sequencer p_seqrh;

extern function new(string name="bridge_virtual_sequencer",uvm_component parent);
endclass

function bridge_virtual_sequencer::new(string name="bridge_virtual_sequencer",uvm_component parent);
super.new(name,parent);
endfunction


