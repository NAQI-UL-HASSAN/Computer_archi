module SingleCycleProcessor_tb(
    input  logic        clk,
    input  logic [31:0] Instruction_Memory,
    input  logic [31:0] pc,
    input  logic [31:0] Imm_Gen,
    input  logic [31:0] alu,
    input  logic [31:0] Reg_File [ 1:0],
    input  logic [ 5:0] Control_Unit,
    input  logic [ 3:0] aluop,
    input  logic [31:0] branch_pc_mux,
    input  logic [31:0] alu_dm_mux,
    input  logic [31:0] regFile_immGen_mux,
    input  logic [31:0] add_pc,
    input  logic [31:0] add_branch,
    input  logic        zero_flag,
    input  logic [ 9:0] inst_alu,
    input  logic [ 6:0] inst_control,
    input  logic [31:0] reg3,
	input  logic [31:0] reg10,
	input  logic [31:0] reg1,
	input  logic [31:0] reg9,
	input  logic [31:0] reg5,
    input  logic [31:0] datamemory36,
    output logic        rst
);

initial begin
    rst = 1'b1;
    @(posedge clk); rst <= 1'b0;
    #20;
    $display("Register 3 has: %h", DUT1.DATAPATH.Reg_file.Registers[3]); //addi
    #10;
    $display("Register 10 has: %h", DUT1.DATAPATH.Reg_file.Registers[10]); //addi
    #10;
    $display("Register 1 has: %h", DUT1.DATAPATH.Reg_file.Registers[1]); //and
    #10;
    $display("Register 36 of DATA MEM has: %h", DUT1.MEMORY.Data_Mem.memory[36]); //sw
    #10;
    $display("Register 9 has: %h", DUT1.DATAPATH.Reg_file.Registers[9]); //lw
    #15;
    $display("Register 5 has: %h", DUT1.DATAPATH.Reg_file.Registers[5]); //or
end
endmodule