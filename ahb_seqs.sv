class ahb_seqs extends uvm_sequence#(write_xtn);
`uvm_object_utils(ahb_seqs)

bit [2:0]hsize;
bit [31:0]haddr;
bit [2:0]hbrust;
bit hwrite;

extern function new(string name="ahb_seqs");
endclass


function ahb_seqs::new(string name="ahb_seqs");
super.new(name);
endfunction

class ahb_single_seqs extends ahb_seqs;
`uvm_object_utils(ahb_single_seqs)

extern function new(string name="ahb_single_seqs");
extern task body;
endclass


function ahb_single_seqs::new(string name="ahb_single_seqs");
super.new(name);
endfunction


task ahb_single_seqs::body;
req=write_xtn::type_id::create("req");
start_item(req);
assert(req.randomize with {HTRANS==2'b10;
			   HWRITE==1;
			   HBRUST==3'b000;})
finish_item(req);
endtask




class ahb_inc4_seqs extends ahb_seqs;
`uvm_object_utils(ahb_inc4_seqs)

extern function new(string name="ahb_inc4_seqs");
extern task body;
endclass

function ahb_inc4_seqs::new(string name="ahb_inc4_seqs");
super.new(name);
endfunction

task ahb_inc4_seqs::body;
req=write_xtn::type_id::create("req");
start_item(req);
assert(req.randomize with {HTRANS==2'b10;
                           HWRITE==0; HBRUST==3'b011;})
finish_item(req);
//for(int i=0;i<3;i++)
//begin
haddr=req.HADDR;
hsize=req.HSIZE;
hwrite=req.HWRITE;
hbrust=req.HBRUST;
if(hbrust==3'b011)
begin
for(int i=0;i<3;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+1'b1;});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+2'b10;});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+3'b100;});

finish_item(req);
haddr=req.HADDR;
end
end
if(hbrust==3'b101)
begin
for(int i=0;i<7;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+1'b1;});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+2'b10;});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+3'b100;});

finish_item(req);
haddr=req.HADDR;
end

end
if(hbrust==3'b111)
begin
for(int i=0;i<3;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+1'b1;});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+2'b10;});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+3'b100;});

finish_item(req);
haddr=req.HADDR;
end
end
if(hbrust==3'b010)
begin
for(int i=0;i<3;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:2],haddr[1:0]+1'b1};});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:3],haddr[2:0]+2'b10};});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:4],haddr[3:0]+3'b100};});

finish_item(req);
haddr=req.HADDR;
end
end
if(hbrust==3'b100)
begin
for(int i=0;i<7;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:3],haddr[2:0]+1'b1};});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:4],haddr[3:0]+2'b10};});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:5],haddr[4:0]+3'b100};});

finish_item(req);
haddr=req.HADDR;
end
end
if(hbrust==3'b110)
begin
for(int i=0;i<15;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:4],haddr[3:0]+1'b1};});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:5],haddr[4:0]+2'b10};});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR=={haddr[31:6],haddr[5:0]+3'b100};});

finish_item(req);
haddr=req.HADDR;
end
end
if(hbrust==3'b001)
begin
for(int i=0;i<req.length-1;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+1'b1;});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+2'b10;});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+3'b100;});

finish_item(req);
haddr=req.HADDR;
end
end

endtask

class ahb_inc8_seqs extends ahb_seqs;
`uvm_object_utils(ahb_inc8_seqs)

extern function new(string name="ahb_inc8_seqs");
extern task body;
endclass

function ahb_inc8_seqs::new(string name="ahb_inc8_seqs");
super.new(name);
endfunction

task ahb_inc8_seqs::body;
req=write_xtn::type_id::create("req");
start_item(req);
assert(req.randomize with {HTRANS==2'b10;
                           HWRITE==1;
                           HBRUST==3'b011;})
finish_item(req);
//for(int i=0;i<3;i++)
//begin
haddr=req.HADDR;
hsize=req.HSIZE;
hwrite=req.HWRITE;
hbrust=req.HBRUST;
for(int i=0;i<7;i++)
begin

start_item(req);
if(hsize==0)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+1'b1;});
else if(hsize==1)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+2'b10;});
else if(hsize==2)
assert(req.randomize with {HTRANS==2'b11; HWRITE==hwrite; HBRUST==hbrust; HSIZE==hsize; HADDR==haddr+3'b100;});

finish_item(req);
haddr=req.HADDR;
end
endtask

