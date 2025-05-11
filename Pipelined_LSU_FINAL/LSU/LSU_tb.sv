module LSU_tb;
logic        clk;
logic [31:0] data_in;
logic [31:0] address;
logic [ 6:0] opcode;
logic        get;
logic        busy;
logic [31:0] data_out;

LSU DUT (.*);

initial begin
    clk = 1'b1;
    forever #5 clk = ~clk;
end

initial begin

    DUT.LSU_datapath.uart_ctrl_reg = 32'd0;

    //write in mem
    opcode = 7'b0100011; data_in = 32'h1234abcd; address = 32'd5;
    #11;
    $display("==================");
    $display("Memory location 5 has: %h", DUT.LSU_datapath.memory[5]);

    //read in mem
    opcode = 7'b0000011; address = 32'd5;
    
    //write in uart
    @(posedge clk);
    opcode = 7'b0100011; data_in = 32'd10; address = 32'h0000040C; //baudrate
    @(posedge clk);
    opcode = 7'b0100011; data_in = 32'h0000000f; address = 32'h00000400; //tx

    //read in uart
    @(posedge clk);
    DUT.LSU_datapath.uart_ctrl_reg[5] = 1'd1;
    DUT.LSU_datapath.uart_rx_reg = 32'habcd1234;
    opcode = 7'b0000011; address = 32'h0000040C; //baudrate
    @(posedge clk);
    opcode = 7'b0000011; address = 32'h00000404; //rx
    @(posedge clk);
    opcode = 7'b0000011; address = 32'h00000400; //tx
end

endmodule