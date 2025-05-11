module Contorller_tb;

    logic [6:0] instruction;
    logic       Branch, MemRead, MemtoReg;
    logic [1:0] ALUOp;
    logic       MemWrite, ALUSrc, RegWrite;

Inst_controller DUT (.*);

initial begin
    instruction = 7'h13;
    end
endmodule