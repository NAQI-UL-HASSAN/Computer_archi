module PipelineProcessor_tb(
    output var logic        clk,
    output var logic        rst,
    //A
    input  var logic [31:0] m1_out_A,     //branch_pc_mux (m1)
    input  var logic [31:0] IM_out_A,
    //B
    input  var logic [31:0] IM_out_B,
    input  var logic [31:0] pc_out_B,
    input  var logic [31:0] ALU_out_B,
    input  var logic        zero_flag,
    //C
    input  var logic [31:0] DM_addr,
    input  var logic [31:0] DM_data,      //regfile read data2
    input  var logic [31:0] regFile_addr
);

initial begin
    rst = 1'b1;
    @(posedge clk); rst <= 1'b0;
    #35;
    $display("Register 1 has: %h", DUT1.DATAPATH.Reg_file.Registers[1]); //addi
    #35;
    $display("Register 2 has: %h", DUT1.DATAPATH.Reg_file.Registers[2]); //addi
    #35;
    $display("Register 4 has: %h", DUT1.DATAPATH.Reg_file.Registers[4]); //add
    #35;
    #35;
    $display("Register 9 has: %h", DUT1.DATAPATH.Reg_file.Registers[9]); //lw
    #35;
    $display("Register 5 has: %h", DUT1.DATAPATH.Reg_file.Registers[5]); //add
    #35;
    $display("Register 11 has: %h", DUT1.DATAPATH.Reg_file.Registers[11]); //add
    #35;
    #10;
    $display("Register 2 has: %h", DUT1.DATAPATH.Reg_file.Registers[2]); //or
    $writememh("Registers_Value.txt", DUT1.DATAPATH.Reg_file.Registers);
    $writememh("DataMemory_Values.txt", DUT1.DATAPATH.Data_Mem.memory);
end

endmodule