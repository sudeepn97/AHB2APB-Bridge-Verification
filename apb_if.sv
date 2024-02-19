interface apb_if(input bit clock);

logic Penable;
logic Pwrite;
logic [31:0]Pwdata;
logic [31:0]Paddr;
logic [3:0]Pselx;
logic [31:0]Prdata;

clocking apb_dr_cb@(posedge clock);
default input #1 output #1;
output Prdata;
input Pwrite;
input Pwdata;
input Paddr;
input Pselx;
input Penable;
endclocking 


clocking apb_mon_cb@(posedge clock);
default input #1 output #1;
input Prdata;
input Pwrite;
input Pwdata;
input Paddr;
input Pselx;
input Penable;
endclocking


modport APB_DR(clocking apb_dr_cb);
modport APB_MON(clocking apb_mon_cb);
endinterface


