module DaM_tb();
   logic unsigned        clk;
   logic unsigned        MemWrite;
   logic unsigned        MemRead;
   logic unsigned [31:0] address;
   logic unsigned [31:0] writeData;
   logic unsigned [31:0] readData;

   DataMemory DUT (.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

   initial begin
    address = 32'h0000004C;
    #10;
    MemWrite = 1;
    #10;
    writeData = 32'd45;
    #10;
    MemWrite = 0; MemRead=1;
    
   end
endmodule