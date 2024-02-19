class ahb_sequencer extends uvm_sequencer#(write_xtn);
`uvm_component_utils(ahb_sequencer);

extern function new(string name="ahb_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass

function ahb_sequencer::new(string name="ahb_sequencer",uvm_component parent);
super.new(name,parent);
endfunction

function void ahb_sequencer::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

