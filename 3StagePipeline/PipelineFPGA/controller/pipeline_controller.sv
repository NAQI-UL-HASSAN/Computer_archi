module pipeline_controller (
    input  var logic       clk,
    input  var logic       rst,
    input  var logic [9:0] inst_alu,
    input  var logic [6:0] inst_control,
    input  var logic       zero_flag,
    output var logic [3:0] alu_op,
    output var logic       alu_src,
    output var logic       memwq, 
    output var logic       memrq,
    output var logic       regwq,
    output var logic       mem2regq,
    output var logic       sel
);

wire logic [1:0] n1;
wire logic       branch, memrd, memwd;
wire logic       mem2regd, regwd;

ALU_controller  ALUcontrol  ( .ALUOp       (n1),
                              .inst_Func7  (inst_alu[9:3]),
                              .inst_Func3  (inst_alu[2:0]),
                              .operation   (alu_op)
                            );

Inst_controller Instcontrol ( .instruction (inst_control),
                              .Branch      (branch), 
                              .MemRead     (memrd), 
                              .MemtoReg    (mem2regd),
                              .ALUOp       (n1),
                              .MemWrite    (memwd), 
                              .ALUSrc      (alu_src), 
                              .RegWrite    (regwd)
                            );

M               M           (.*);

WB              WB          (.*);

    always_comb begin
        sel = branch & zero_flag;
    end
    
endmodule