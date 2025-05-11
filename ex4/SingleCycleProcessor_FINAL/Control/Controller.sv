module Controller (
    input  var logic [9:0] inst_alu,
    input  var logic [6:0] inst_control,
    input  var logic       zero_flag,
    output var logic [3:0] alu_op,
    output var logic       memr, sel2, memw, alu_src, regw, sel
);

wire logic [1:0] n1;
wire logic       n2;

ALU_controller  ALUcontrol  ( .ALUOp       (n1),
                              .inst_Func7  (inst_alu[9:3]),
                              .inst_Func3  (inst_alu[2:0]),
                              .operation   (alu_op)
                            );

Inst_controller Instcontrol ( .instruction (inst_control),
                              .Branch      (n2), 
                              .MemRead     (memr), 
                              .MemtoReg    (sel2),
                              .ALUOp       (n1),
                              .MemWrite    (memw), 
                              .ALUSrc      (alu_src), 
                              .RegWrite    (regw)
                            );

    always_comb begin
        sel = n2 & zero_flag;
    end
    
endmodule