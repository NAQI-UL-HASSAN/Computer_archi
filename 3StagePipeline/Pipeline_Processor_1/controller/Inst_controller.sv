module Inst_controller (
    input  var logic [6:0] instruction,
    output var logic       Branch, MemRead, MemtoReg,
    output var logic [1:0] ALUOp,
    output var logic       MemWrite, ALUSrc, RegWrite
);

    always_comb begin
        case (instruction)
            7'b0110011: begin
                Branch   = 0;
                MemRead  = 0;
                MemtoReg = 0;
                ALUOp    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
            end
            7'b0000011: begin
                Branch   = 0;
                MemRead  = 1;
                MemtoReg = 1;
                ALUOp    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 1;
            end
            7'b0100011: begin
                Branch   = 0;
                MemRead  = 0;
                MemtoReg = 0;
                ALUOp    = 2'b00;
                MemWrite = 1;
                ALUSrc   = 1;
                RegWrite = 0;
            end
            7'b1100011: begin
                Branch   = 1;
                MemRead  = 0;
                MemtoReg = 0;
                ALUOp    = 2'b01;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;
            end
            7'b0010011: begin
                Branch   = 0;
                MemRead  = 0;
                MemtoReg = 0;
                ALUOp    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 1;
            end
            default: begin
                Branch   = 0;
                MemRead  = 0;
                MemtoReg = 0;
                ALUOp    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;
            end
        endcase
    end

endmodule