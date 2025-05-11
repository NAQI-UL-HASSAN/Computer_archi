module PipelineProcessor_tb(
    input  var logic        clk,
    input  var logic [31:0] fpga,
    output var logic        rst
);

initial begin
    rst = 1'b1;
    @(posedge clk); rst <= 1'b0;
    #35;
    $display("Register 3 has: %h", DUT1.DATAPATH.Reg_file.Registers[3]); //addi
    #35;
    $display("Register 10 has: %h", DUT1.DATAPATH.Reg_file.Registers[10]); //addi
    #35;
    $display("Register 1 has: %h", DUT1.DATAPATH.Reg_file.Registers[1]); //and
    #35;
    #35;
    $display("Register 9 has: %h", DUT1.DATAPATH.Reg_file.Registers[9]); //lw
    #35;
    #10;
    $display("Register 5 has: %h", DUT1.DATAPATH.Reg_file.Registers[5]); //or
end

endmodule