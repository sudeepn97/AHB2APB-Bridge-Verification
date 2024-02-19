module top;
import bridge_pkg::*;
import uvm_pkg::*;

bit clock;
always #10 clock=~clock;

ahb_if in0(clock);
apb_if in1(clock);

rtl_top DUT(.Hclk(in0.clock),.Hresetn(in0.Hresetn),.Htrans(in0.Htrans),.Haddr(in0.Haddr),.Hwrite(in0.Hwrite),.Hreadyin(in0.Hreadyin),.Hsize(in0.Hsize),.Hwdata(in0.Hwdata),.Hrdata(in0.Hrdata),.Hresp(in0.Hresp),.Hreadyout(in0.Hreadyout),.Prdata(in1.Prdata),.Pselx(in1.Pselx),.Pwrite(in1.Pwrite),.Penable(in1.Penable),.Paddr(in1.Paddr),.Pwdata(in1.Pwdata));
initial
begin
uvm_config_db#(virtual ahb_if)::set(null,"*","vif_0",in0);
uvm_config_db#(virtual apb_if)::set(null,"*","vif_1",in1);

run_test();
end
endmodule

