module SingleCycleProcessor(
    input  var logic        clk,
    input  var logic        rst,
    output var logic [31:0] reg3,
	output var logic [31:0] reg10,
	output var logic [31:0] reg1,
	output var logic [31:0] reg9,
	output var logic [31:0] reg5,
    output var logic [31:0] datamemory36,
    output var logic [31:0] n5,                //Inst Mem
    output var logic [31:0] n1,                //PC
    output var logic [31:0] imm,               //Imm Gen
    output var logic [31:0] n3,                //ALU
    output var logic [31:0] add_pc,            //PC adder
    output var logic [31:0] add_branch,        //Branch Adder
    output var logic [31:0] regFile_immGen_mux,//m2
    output var logic [31:0] alu_dm_mux,        //m3
    output var logic        a2,                //memw
    output var logic        a3,                //memr
    output var logic        a5,                //sel2
    output var logic        a6,                //sel
    output var logic        a7,                //alu src
    output var logic        a8,                //regw
    output var logic [ 3:0] a10,               //alu op
    output var logic [31:0] branch_pc_mux,     //m1
    output var logic [31:0] n2,                //rd2
    output var logic [31:0] rd1,                //rd1
    output var logic        a4, //ZERO FLAG
    output var logic [ 9:0] a9, //inst_alu
    output var logic [ 6:0] a1 //inst control
);

wire logic [31:0] n4;


processor_datapath DATAPATH   (.clk          (clk),
                               .rst          (rst),
                               .reg3         (reg3),
                               .reg10        (reg10),
                               .reg1         (reg1),
                               .reg9         (reg9),
                               .reg5         (reg5),
                               .regw         (a8),
                               .inst         (n5),
                               .sel          (a6),
                               .alu_src      (a7),
                               .alu_op       (a10),
                               .sel2         (a5),
                               .data_out     (n4),
                               .out_add      (n1),
                               .inst_control (a1),
                               .inst_alu     (a9),
                               .zero_flag    (a4),
                               .rd2          (n2),
                               .alu_out      (n3),
                               .imm          (imm),
                               .n1           (add_pc),
                               .n2           (add_branch),
                               .a2           (regFile_immGen_mux),
                               .a1           (alu_dm_mux),
                               .in_add       (branch_pc_mux),
                               .rd1          (rd1)
                              );

Memory             MEMORY     (.out_add      (n1),
                               .clk          (clk),
                               .memw         (a2), 
                               .memr         (a3),
                               .alu_out      (n3),
                               .rd2          (n2),
                               .data_out     (n4),
                               .inst         (n5),
                               .datamemory36 (datamemory36)
                              );

Controller         CONTROLLER (.inst_alu     (a9),
                               .inst_control (a1),
                               .zero_flag    (a4),
                               .alu_op       (a10),
                               .memr         (a3), 
                               .sel2         (a5), 
                               .memw         (a2), 
                               .alu_src      (a7), 
                               .regw         (a8), 
                               .sel          (a6)
                              );
endmodule