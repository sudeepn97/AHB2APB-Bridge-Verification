class bridge_base_test extends uvm_test;
`uvm_component_utils(bridge_base_test)

bridge_env envh;
env_config m_tb_cfg;
ahb_config m_ahb_cfg;
apb_config m_apb_cfg;
int has_apb_agent=1;
int has_ahb_agent=1;
int has_virtual_sequencer=1;

extern function new(string name="bridge_base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass


function bridge_base_test::new(string name="bridge_base_test",uvm_component parent);
super.new(name,parent);
endfunction


function void bridge_base_test::build_phase(uvm_phase phase);
super.build_phase(phase);
m_tb_cfg=env_config::type_id::create("m_tb_cfg");
begin
m_ahb_cfg=ahb_config::type_id::create("m_ahb_cfg");
if(!uvm_config_db#(virtual ahb_if)::get(this,"","vif_0",m_ahb_cfg.vif))
`uvm_fatal("config","cannot get vif. Have you set it?")

m_ahb_cfg.is_active=UVM_ACTIVE;
m_tb_cfg.m_ahb_cfg=m_ahb_cfg;
end
begin
m_apb_cfg=apb_config::type_id::create("m_ap_cfg");
if(!uvm_config_db#(virtual apb_if)::get(this,"","vif_1",m_apb_cfg.vif))
`uvm_fatal("config","cannot get vif. Have you set it?")

m_apb_cfg.is_active=UVM_ACTIVE;
m_tb_cfg.m_apb_cfg=m_apb_cfg;
end

m_tb_cfg.has_ahb_agent=has_ahb_agent;
m_tb_cfg.has_apb_agent=has_apb_agent;
m_tb_cfg.has_virtual_sequencer=has_virtual_sequencer;
uvm_config_db#(env_config)::set(this,"*","env_config",m_tb_cfg);
envh=bridge_env::type_id::create("envh",this);
endfunction

class bridge_single_test extends bridge_base_test;
`uvm_component_utils(bridge_single_test)
bridge_single_vseqs v_seqh;

extern function new(string name="bridge_single_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

function bridge_single_test::new(string name="bridge_single_test",uvm_component parent);
super.new(name,parent);
endfunction


function void bridge_single_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


task bridge_single_test::run_phase(uvm_phase phase);
phase.raise_objection(this);
v_seqh=bridge_single_vseqs::type_id::create("v_seqh");
v_seqh.start(envh.v_seqrh);
#80;
phase.drop_objection(this);
endtask


