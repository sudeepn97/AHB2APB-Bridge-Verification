class apb_agent extends uvm_agent;
`uvm_component_utils(apb_agent)

apb_sequencer seqrh;
apb_driver drvh;
apb_monitor monh;

apb_config m_cfg;

extern function new(string name="apb_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
//extern function void connect_phase(uvm_phase phase);
endclass

function apb_agent::new(string name="apb_agent",uvm_component parent=null);
super.new(name,parent);
endfunction

function void apb_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
monh=apb_monitor::type_id::create("monh",this);
if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it?")
if(m_cfg.is_active==UVM_ACTIVE)
begin
drvh=apb_driver::type_id::create("drvh",this);
seqrh=apb_sequencer::type_id::create("seqrh",this);
end

endfunction


//function void apb_agent::connect_phase(uvm_phase phase);
//if(m_cfg.is_active==UVM_ACTIVE)
//drvh.seq_item_port.connect(seqrh.seq_item_export);
//endfunction

