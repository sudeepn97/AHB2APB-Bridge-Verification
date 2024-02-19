class ahb_monitor extends uvm_monitor;
`uvm_component_utils(ahb_monitor);
virtual ahb_if.AHB_MON vif;
ahb_config m_cfg;

extern function new(string name="ahb_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect();
extern function void report_phase(uvm_phase phase);

endclass

function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
super.new(name,parent);
endfunction

function void ahb_monitor::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it")
endfunction


function void ahb_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task ahb_monitor::run_phase(uvm_phase phase);
super.run_phase(phase);
//$display("mtime=%t",$time);
//if(vif.ahb_mon_cb.Hreadyout)
while(vif.ahb_mon_cb.Hreadyout!==1)
@(vif.ahb_mon_cb);
forever 
begin
collect();
end
//$display("m2time=%t",$time);
endtask


task ahb_monitor::collect();
write_xtn mon_hdata;
mon_hdata=write_xtn::type_id::create("mon_hdata");
begin

//@(vif.ahb_mon_cb);
while(vif.ahb_mon_cb.Htrans!==2'b10 && vif.ahb_mon_cb.Htrans!==2'b11)
@(vif.ahb_mon_cb);
mon_hdata.HADDR=vif.ahb_mon_cb.Haddr;
mon_hdata.HTRANS=vif.ahb_mon_cb.Htrans;
mon_hdata.HSIZE=vif.ahb_mon_cb.Hsize;
mon_hdata.HBRUST=vif.ahb_mon_cb.Hbrust;
mon_hdata.HREADYin=vif.ahb_mon_cb.Hreadyin;
mon_hdata.HWRITE=vif.ahb_mon_cb.Hwrite;
@(vif.ahb_mon_cb);
//repeat(3)
//@(vif.ahb_mon_cb);
while(vif.ahb_mon_cb.Hreadyout!==1)
@(vif.ahb_mon_cb);
if(vif.ahb_mon_cb.Hwrite)
mon_hdata.HWDATA=vif.ahb_mon_cb.Hwdata;
else
mon_hdata.HRDATA=vif.ahb_mon_cb.Hrdata;
//repeat(3)
//@(vif.ahb_mon_cb);
end
`uvm_info("AHB_MONITOR",$sformatf("printing from the AHB monitor \n %s",mon_hdata.sprint()),UVM_LOW)
m_cfg.mon_data_cnt++;
//mon_hdata.print;
endtask

function void ahb_monitor::report_phase(uvm_phase phase);
`uvm_info("recieving data",$sformatf("monitor data count %0d",m_cfg.mon_data_cnt),UVM_LOW)
endfunction
