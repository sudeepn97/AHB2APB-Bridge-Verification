class bridge_env extends uvm_env;
`uvm_component_utils(bridge_env)

bridge_virtual_sequencer v_seqrh;
env_config m_tb_cfg;
ahb_agt_top ahb_toph;
apb_agt_top apb_toph;

extern function new(string name="bridge_env",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


function bridge_env::new(string name="bridge_env",uvm_component parent);
super.new(name,parent);
endfunction


function void bridge_env::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(env_config)::get(this,"","env_config",m_tb_cfg))
`uvm_fatal("config","cannot get cfg. Have you set it?")
if(m_tb_cfg.has_ahb_agent)

ahb_toph=ahb_agt_top::type_id::create("ahb_toph",this);
$display("created top h");
if(m_tb_cfg.has_apb_agent)
apb_toph=apb_agt_top::type_id::create("apb_toph",this);
if(m_tb_cfg.has_virtual_sequencer)
v_seqrh=bridge_virtual_sequencer::type_id::create("v_seqrh",this);
endfunction

function void bridge_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(m_tb_cfg.has_virtual_sequencer)
begin
v_seqrh.h_seqrh=ahb_toph.agnth.seqrh;
v_seqrh.p_seqrh=apb_toph.agnth.seqrh;
end
endfunction
