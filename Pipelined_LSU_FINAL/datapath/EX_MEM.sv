module EX_MEM (
    input  var logic        clk,
    input  var logic        rst,
    input  var logic        en,
    input  var logic [31:0] alu_resultd,
    input  var logic [31:0] rd2d,
    input  var logic [31:0] instd1,
    output var logic [31:0] alu_resultq,
    output var logic [31:0] rd2q,
    output var logic [31:0] instq1
);
    always_ff @(posedge clk) begin
        if (rst) begin 
            alu_resultq <= 32'b0;
            rd2q        <= 32'b0;
            instq1      <= 32'b0;
        end
        else if (en) begin
            alu_resultq <= alu_resultd;
            rd2q        <= rd2d;
            instq1      <= instd1;
        end
    end
endmodule