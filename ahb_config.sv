class ahb_config extends uvm_object;
`uvm_object_utils(ahb_config)

uvm_active_passive_enum is_active=UVM_ACTIVE;
virtual ahb_if vif;
int drv_data_cnt=0;
int mon_data_cnt=0;
extern function new(string name="ahb_config");
endclass

function ahb_config::new(string name="ahb_config");
super.new(name);
endfunction

