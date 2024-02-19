class ahb_driver extends uvm_driver#(write_xtn);
`uvm_component_utils(ahb_driver)
virtual ahb_if.AHB_DR vif;

ahb_config m_cfg;
extern function new(string name="ahb_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send2dut(write_xtn xtn);
extern function void report_phase(uvm_phase phase);
endclass


function ahb_driver::new(string name="ahb_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void ahb_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it")

endfunction 


function void ahb_driver::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task ahb_driver::run_phase(uvm_phase phase);
@(vif.ahb_dr_cb);
vif.ahb_dr_cb.Hresetn<=0;
@(vif.ahb_dr_cb);
vif.ahb_dr_cb.Hresetn<=1;
@(vif.ahb_dr_cb);
forever
begin
seq_item_port.get_next_item(req);
send2dut(req);
seq_item_port.item_done;
end
endtask


task ahb_driver::send2dut(write_xtn xtn);
begin
xtn.HREADYout=1'b1;
//`uvm_info("AHB_DRIVER",$sformatf("printing from the AHB driver \n %s",req.sprint()),UVM_LOW)
//@(vif.ahb_dr_cb);
vif.ahb_dr_cb.Htrans<=xtn.HTRANS;
vif.ahb_dr_cb.Hsize<=xtn.HSIZE;
vif.ahb_dr_cb.Hbrust<=xtn.HBRUST;
vif.ahb_dr_cb.Haddr<=xtn.HADDR;
vif.ahb_dr_cb.Hreadyin<=1'b1;
vif.ahb_dr_cb.Hwrite<=xtn.HWRITE;
@(vif.ahb_dr_cb);
//xtn.HREADYout<=1'b1;
while(vif.ahb_dr_cb.Hreadyout!==1)
@(vif.ahb_dr_cb);
begin

if(xtn.HWRITE==1)
vif.ahb_dr_cb.Hwdata<=xtn.HWDATA;
else
vif.ahb_dr_cb.Hwdata<=32'b0;
//@(vif.ahb_dr_cb);
end
end
m_cfg.drv_data_cnt++;
endtask

function void ahb_driver::report_phase(uvm_phase phase);
`uvm_info("driving data count",$sformatf("count is %0d",m_cfg.drv_data_cnt),UVM_LOW)
endfunction



