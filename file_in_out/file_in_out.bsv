package file_in_out;

import RegFile :: *;

typedef enum {READ, WRITE} State deriving(Bounded, Bits, Eq);

(* synthesize *)

module mkfile_io (Empty);

Reg#(Bit#(32)) rd_addr <- mkReg(0);
Reg#(Bit#(32)) wr_addr <- mkReg(9999);
Reg#(Bit#(32)) rg_limit <- mkReg(10);
Reg#(State)    rg_state <- mkReg(READ);

// Create Register files to use as inputs in a testbench
RegFile#(Bit#(32), Bit#(32)) memory_rd <- mkRegFileLoad("memory.dat", 0, 9);
Reg#(File)                   memory_wr <- mkReg(InvalidFile) ;

//read the values from the Memory (Text File)
rule read_file(rd_addr < rg_limit && rg_state == READ);
    $display("Data in addr:%h = %h",rd_addr, memory_rd.sub(rd_addr));
    rd_addr <= rd_addr + 1;
endrule


rule open(wr_addr == 9999 && rg_state == WRITE) ; //Open Initially
    // Open the file and check for proper opening
    File file <- $fopen( "memory.dat","w" ) ;
    if ( file == InvalidFile )
    begin
    $display("cannot open the file" );
    $finish(0);
    end
    wr_addr <= 0 ;
    memory_wr <= file ; // Save the file in a Register
endrule


rule write (wr_addr < rg_limit && wr_addr != 9999 && rg_state == WRITE);
    $fwrite( memory_wr , "%0h\n", wr_addr << 1); // Writes to memory.dat
     $display("Writing data:%h in addr:%h",wr_addr << 1, wr_addr);
    wr_addr <= wr_addr + 1;
endrule

endmodule: mkfile_io


endpackage
