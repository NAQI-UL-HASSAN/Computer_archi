module WB (
    input  var logic        clk,
    input  var logic        rst,
    input  var logic [31:0] mem2regd,
    input  var logic [31:0] regwd,
    output var logic [31:0] mem2regq,
    output var logic [31:0] regwq
);
    always_ff @(posedge clk) begin
        if (rst)begin 
            mem2regq <= 1'b0;
            regwq    <= 1'b0;
        end
        else begin
            mem2regq <= mem2regd;
            regwq    <= regwd;
        end
    end
endmodule