module processor_datapath(
    input  var logic        clk,
    input  var logic        rst,
    input  var logic        regw,
    input  var logic [31:0] inst,
    input  var logic        sel,
    input  var logic        alu_src,
    input  var logic [ 3:0] alu_op,
    input  var logic        sel2,
    input  var logic [31:0] data_out,
    output var logic [31:0] reg3,
	output var logic [31:0] reg10,
	output var logic [31:0] reg1,
	output var logic [31:0] reg9,
	output var logic [31:0] reg5,
    output var logic [31:0] out_add,
    output var logic [ 6:0] inst_control,
    output var logic [ 9:0] inst_alu,
    output var logic        zero_flag,
    output var logic [31:0] alu_out,
    output var logic [31:0] imm,    //imm gen output
    output var logic [31:0] n1, n2, //adders output
    output var logic [31:0] a2,     //regFile_immGen_mux output (m2)
    output var logic [31:0] a1,     //alu_dm_mux (m3)
    output var logic [31:0] in_add, //branch_pc_mux (m1)
    output var logic [31:0] rd2,    //regfile read data2
    output var logic [31:0] rd1     //regfile read data1
);

always_comb begin
    inst_control = inst[6:0];
    inst_alu     = {inst[31:25], inst[14:12]};
end

PC        PC        (.clk                 (clk),
                     .rst                 (rst),
                     .in_address          (in_add),
                     .out_address         (out_add)
                    );

Add2      Add2      (.operand111          (out_add),
                     .Sum1                (n1)
                    );

imm_gen   imm_gen   (.instruction         (inst),
                     .imm_val             (imm)
                    );

Add       Add       (.operand11           (out_add),
                     .operand22           (imm),
                     .Sum                 (n2)
                    ); 

Mux       m1        (.in1                 (n1),
                     .in2                 (n2),
                     .out                 (in_add),
                     .MemtoReg            (sel)
                    );  

Registers Reg_file  (.Read_reg1           (inst[19:15]),
                     .Read_reg2           (inst[24:20]),
                     .reg3                (reg3),
                     .reg10               (reg10),
                     .reg1                (reg1),
                     .reg9                (reg9),
                     .reg5                (reg5),
                     .Write_reg           (inst[11:7]),
                     .Write_data          (a1),
                     .Read_data1          (rd1),
                     .Read_data2          (rd2),
                     .clk                 (clk),
                     .RegWrite            (regw)
                    ); 

Mux       m2        (.in1                 (rd2),
                     .in2                 (imm),
                     .out                 (a2),
                     .MemtoReg            (alu_src)
                    );        

ALU       alu       (.operand1            (rd1),
                     .operand2            (a2),
                     .ALUresult           (alu_out),
                     .ALUoperation        (alu_op),
                     .zero                (zero_flag)
                    );    

Mux       m3        (.in1                 (alu_out),
                     .in2                 (data_out),
                     .out                 (a1),
                     .MemtoReg            (sel2)
                    );  
endmodule