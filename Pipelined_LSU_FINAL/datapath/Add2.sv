module Add2 (
    output var logic unsigned [31:0] Sum1,
    input  var logic       pipe_en,
    input  var logic unsigned [31:0] operand111
);

    always_comb begin
        if (pipe_en) begin
        Sum1 = operand111 + 32'd4;
        end
    end
    
endmodule