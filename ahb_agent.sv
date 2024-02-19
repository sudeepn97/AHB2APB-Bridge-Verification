class ahb_agent extends uvm_agent;
`uvm_component_utils(ahb_agent)

ahb_sequencer seqrh;
ahb_driver drvh;
ahb_monitor monh;

ahb_config m_cfg;

extern function new(string name="ahb_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function ahb_agent::new(string name="ahb_agent",uvm_component parent=null);
super.new(name,parent);
endfunction

function void ahb_agent::build_phase(uvm_phase phase);
super.build_phase(phase);
monh=ahb_monitor::type_id::create("monh",this);
if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it?")
if(m_cfg.is_active==UVM_ACTIVE)
begin
drvh=ahb_driver::type_id::create("drvh",this);
seqrh=ahb_sequencer::type_id::create("seqrh",this);
end

endfunction


function void ahb_agent::connect_phase(uvm_phase phase);
if(m_cfg.is_active==UVM_ACTIVE)
drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction
