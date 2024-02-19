class apb_seqs extends uvm_sequence#(read_xtn);
`uvm_object_utils(apb_seqs)

extern function new(string name="apb_seqs");
endclass


function apb_seqs::new(string name="apb_seqs");
super.new(name);
endfunction

class apb_read_seqs extends apb_seqs;
`uvm_object_utils(apb_read_seqs)

extern function new(string name="apb_read_seqs");
extern task body();
endclass

function apb_read_seqs::new(string name="apb_read_seqs");
super.new(name);
endfunction

task apb_read_seqs::body();
req=read_xtn::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
