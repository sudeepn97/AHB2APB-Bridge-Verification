class apb_monitor extends uvm_monitor;
`uvm_component_utils(apb_monitor)

virtual apb_if.APB_MON vif;
apb_config m_cfg;
extern function new(string name="apb_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect();
extern function void report_phase(uvm_phase phase);

endclass

function apb_monitor::new(string name="apb_monitor",uvm_component parent);
super.new(name,parent);
endfunction

function void apb_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it")
endfunction


function void apb_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=m_cfg.vif;
endfunction

task apb_monitor::run_phase(uvm_phase phase);
super.run_phase(phase);
//hbrust=vif.apb_mon_cb.Hbrust;
forever
begin
collect();
end
endtask


task apb_monitor::collect();
read_xtn mon_pdata;
mon_pdata=read_xtn::type_id::create("mon_pdata");
begin
wait(vif.apb_mon_cb.Pselx!==0)
@(vif.apb_mon_cb);
mon_pdata.Paddr=vif.apb_mon_cb.Paddr;
mon_pdata.Pwrite=vif.apb_mon_cb.Pwrite;
mon_pdata.Pselx=vif.apb_mon_cb.Pselx;
if(vif.apb_mon_cb.Pwrite)
begin

mon_pdata.Pwdata=vif.apb_mon_cb.Pwdata;
end
else
mon_pdata.Prdata=vif.apb_mon_cb.Prdata;
@(vif.apb_mon_cb);
end
mon_pdata.print;
m_cfg.mon_data_cnt++;

endtask

function void apb_monitor::report_phase(uvm_phase phase);
`uvm_info("Receiving",$sformatf("Receiving data count %0d",m_cfg.mon_data_cnt),UVM_LOW)
endfunction
