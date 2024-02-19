class env_config extends uvm_object;
`uvm_object_utils(env_config)

int has_ahb_agent=1;
int has_apb_agent=1;
int has_virtual_sequencer=1;
ahb_config m_ahb_cfg;
apb_config m_apb_cfg;

extern function new(string name="env_config");
endclass

function env_config ::new(string name="env_config");
super.new(name);
endfunction



