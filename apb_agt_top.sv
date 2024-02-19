class apb_agt_top extends uvm_env;
`uvm_component_utils(apb_agt_top)

apb_agent agnth;
apb_config m_cfg;
env_config m_tb_cfg;

extern function new(string name="apb_agt_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
//extern function void report_phase(uvm_phase phase);
endclass


function apb_agt_top::new(string name="apb_agt_top",uvm_component parent);
super.new(name,parent);
endfunction

function void apb_agt_top::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(env_config)::get(this,"","env_config",m_tb_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it?")

m_cfg=apb_config::type_id::create("m_cfg");
agnth=apb_agent::type_id::create("agnth",this);
uvm_config_db#(apb_config)::set(this,"agnth*","apb_config",m_tb_cfg.m_apb_cfg);
endfunction

//function void apb_agt_top::report_phase(uvm_phase phase);
//uvm_top.print_topology();
//endfunction


