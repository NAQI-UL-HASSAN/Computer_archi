module top();
    logic        clk;
    logic [31:0] Instruction_Memory;
    logic [31:0] pc;
    logic [31:0] Imm_Gen;
    logic [31:0] alu;
    logic [31:0] Reg_File [ 1:0];
    logic [ 5:0] Control_Unit;
    logic [ 3:0] aluop;
    logic [31:0] branch_pc_mux;
    logic [31:0] alu_dm_mux;
    logic [31:0] regFile_immGen_mux;
    logic [31:0] add_pc;
    logic [31:0] add_branch;
    logic        zero_flag;
    logic [ 9:0] inst_alu;
    logic [ 6:0] inst_control;
    logic        rst;
    logic [31:0] reg3;
	logic [31:0] reg10;
	logic [31:0] reg1;
	logic [31:0] reg9;
	logic [31:0] reg5;
    logic [31:0] datamemory36;

    SingleCycleProcessor    DUT1 (
        .clk                (clk),
        .rst                (rst),
        .reg3               (reg3),
        .reg10              (reg10),
        .reg1               (reg1),
        .reg9               (reg9),
        .reg5               (reg5),
        .datamemory36       (datamemory36),
        .n5                 (Instruction_Memory),
        .n1                 (pc),
        .imm                (Imm_Gen),
        .n3                 (alu),
        .add_pc             (add_pc),
        .add_branch         (add_branch),
        .regFile_immGen_mux (regFile_immGen_mux),
        .alu_dm_mux         (alu_dm_mux),
        .a2                 (Control_Unit[0]),//memw
        .a3                 (Control_Unit[1]),//memr
        .a5                 (Control_Unit[2]),//sel2
        .a6                 (Control_Unit[3]),//sel
        .a7                 (Control_Unit[4]),//alu src
        .a8                 (Control_Unit[5]),//regw
        .a10                (aluop),          //alu op
        .branch_pc_mux      (branch_pc_mux),
        .n2                 (Reg_File[1]),    //rd2
        .rd1                (Reg_File[0]),     //rd1
        .a4                 (zero_flag),
        .a9                 (inst_alu),    //rd2
        .a1                 (inst_control)     //rd1
    );

    SingleCycleProcessor_tb  DUT2 (.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $readmemh("InstructionMemory.txt",DUT1.MEMORY.Inst_Mem.memory);
    end

endmodule