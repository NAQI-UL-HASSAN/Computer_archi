module IF_ID (
    input  var logic        clk,
    input  var logic        en,
    input  var logic        flush,
    input  var logic        rst,
    input  var logic [31:0] instd,
    input  var logic [31:0] pcd,
    output var logic [31:0] instq,
    output var logic [31:0] pcq
);
    always_ff @(posedge clk) begin
        if (rst || flush) begin 
            pcq   <= 32'b0;
            instq <= 32'b0;
        end
        else if (en) begin
            pcq   <= pcd;
            instq <= instd;
        end
    end
endmodule