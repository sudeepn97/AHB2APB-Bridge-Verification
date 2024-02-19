class apb_sequencer extends uvm_sequencer#(read_xtn);
`uvm_component_utils(apb_sequencer);

extern function new(string name="apb_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function apb_sequencer::new(string name="apb_sequencer",uvm_component parent);
super.new(name,parent);
endfunction

function void apb_sequencer::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

