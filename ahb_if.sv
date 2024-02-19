interface ahb_if(input bit clock);

logic Hresetn;
logic [1:0]Htrans;
logic Hwrite;
logic Hreadyin;
logic Hreadyout;
logic [1:0]Hresp;
logic [31:0]Hwdata;
logic [31:0]Hrdata;
logic [31:0]Haddr;
logic [2:0]Hsize;
logic [2:0]Hbrust;
clocking ahb_dr_cb@(posedge clock);
default input #1 output #1;
output Hresetn;
output Htrans;
output Hwrite;
output Hreadyin;
output Hwdata;
output Haddr;
input Hreadyout;
input Hresp;
input Hrdata;
output Hsize;
output Hbrust;
endclocking 

clocking ahb_mon_cb@(posedge clock);
default input #1 output #1;
input Hresetn;
input Htrans;
input Hwrite;
input Hreadyin;
input Hwdata;
input Haddr;
input Hreadyout;
input Hresp;
input Hrdata;
input Hsize;
input Hbrust;
endclocking 


modport AHB_DR(clocking ahb_dr_cb);
modport AHB_MON(clocking ahb_mon_cb);
endinterface

