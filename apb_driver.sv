class apb_driver extends uvm_driver#();
`uvm_component_utils(apb_driver)
virtual apb_if.APB_DR vif;
apb_config m_cfg;
extern function new(string name="apb_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send2dut();
extern function void report_phase(uvm_phase phase);
endclass


function apb_driver::new(string name="apb_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(apb_config)::get(this,"","apb_config",m_cfg))
`uvm_fatal("config","cannot get m_cfg. Have you set it")

endfunction


function void apb_driver::connect_phase(uvm_phase phase);
super.connect_phase(phase);
vif=m_cfg.vif;
endfunction


task apb_driver::run_phase(uvm_phase phase);

super.run_phase(phase);
begin
//seq_item_port.get_next_item(req);


send2dut();
//seq_item_port.item_done();
end
endtask

task apb_driver::send2dut();
read_xtn req;
req=read_xtn::type_id::create("req");
forever
begin
wait(vif.apb_dr_cb.Pselx!==0)
$display("ok");
if(vif.apb_dr_cb.Pwrite==0)
req.Prdata={$random};
vif.apb_dr_cb.Prdata<=req.Prdata;
repeat(2)
@(vif.apb_dr_cb);

//end
req.print;

m_cfg.drv_data_cnt++;
end
endtask


function void apb_driver::report_phase(uvm_phase phase);
`uvm_info("Driving",$sformatf("Driving data count %0d",m_cfg.drv_data_cnt),UVM_LOW)
endfunction

