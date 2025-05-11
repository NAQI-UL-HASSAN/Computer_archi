
module ALU_tb;
    var logic unsigned        zero;
    var logic unsigned [31:0] ALUresult;
    var logic unsigned [31:0] operand1;
    var logic unsigned [31:0] operand2;
    var logic unsigned [ 3:0] ALUoperation;
        
    ALU DUT (.*);

    initial begin
    operand1 = 32'b111111110111;
    operand2 = 32'b000000001100;
    ALUoperation = 4'b0010;

    end

endmodule