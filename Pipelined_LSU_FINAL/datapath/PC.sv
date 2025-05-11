module PC (
    output var logic unsigned [31:0] out_address,
	input  var logic unsigned [31:0] in_address,
	input  var logic pipe_en,
 	input  var logic unsigned 		 clk, rst
);

	always_ff @(posedge clk) begin
		if (rst) begin
			out_address <= 32'd0;
		end
		else if (pipe_en) begin
			out_address <= in_address;
		end
	end

endmodule