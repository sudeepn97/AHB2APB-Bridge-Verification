class write_xtn extends uvm_sequence_item;
`uvm_object_utils(write_xtn)

bit HRESTn;
rand bit [1:0] HTRANS;
rand bit [31:0] HWDATA;
rand bit [31:0] HADDR;
rand bit [2:0] HBRUST;
rand bit [2:0] HSIZE;
rand bit HWRITE;
bit [31:0]HRDATA;
bit HREADYin;
bit HREADYout;
bit [1:0]Hresp;
rand bit [9:0]length;

constraint valid_hsize{HSIZE inside{[0:2]};}
constraint valid_haddr{HADDR inside{[32'h8000_0000:32'h8000_03FF],[32'h8400_0000:32'h8400_03FF],
				    [32'h8800_0000:32'h8800_03FF],[32'h8C00_0000:32'h8C00_03FF]};}
constraint wr_rd_data{HWRITE==0 -> HWDATA==0;}
constraint valid_len{(2**HSIZE)*length<=1024;}
constraint valid_Half_addr{(HSIZE==1)->(HADDR%2==0);}
constraint valid_word_addr{(HSIZE==2)->(HADDR%4==0);}
constraint data_len{if(HBRUST==3'h0) (length==1);
		    if(HBRUST==3'h1) (length >=1 && length < (1024/(2**HSIZE)));
		    if(HBRUST==3'h2) (length==4);
		    if(HBRUST==3'h3) (length==4);
		    if(HBRUST==3'h4) (length==8);
		    if(HBRUST==3'h5) (length==8);
		    if(HBRUST==3'h6) (length==16);
		    if(HBRUST==3'h7) (length==16);}




extern function new(string name="write_xtn");
extern function void do_print(uvm_printer printer);
endclass


function write_xtn::new(string name="write_xtn");
super.new(name);
endfunction


function void write_xtn::do_print(uvm_printer printer);
printer.print_field("HTRANS",         this.HTRANS,        2,        UVM_BIN           );
printer.print_field("HADDR", 	      this.HADDR,	  32,       UVM_HEX	      );
printer.print_field("HBRUST",         this.HBRUST,	  3,        UVM_HEX           );
printer.print_field("HWRITE",         this.HWRITE,        1,        UVM_BIN           );
printer.print_field("HWDATA",         this.HWDATA,        32,       UVM_HEX           );
printer.print_field("HREADYout",      this.HREADYout,     1,        UVM_BIN           );
printer.print_field("HSIZE",          this.HSIZE,         3,        UVM_HEX           );
printer.print_field("HRDATA",         this.HRDATA,        32,       UVM_HEX           );
	        
endfunction

