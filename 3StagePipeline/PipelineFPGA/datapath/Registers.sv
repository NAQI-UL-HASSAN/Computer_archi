module Registers (
	output var logic unsigned [31:0] Read_data1,
 	output var logic unsigned [31:0] Read_data2,
	output var logic unsigned [31:0] fpga,
	input  var logic unsigned [ 4:0] Read_reg1,
	input  var logic unsigned [ 4:0] Read_reg2,
	input  var logic unsigned [ 4:0] Write_reg,
	input  var logic unsigned [31:0] Write_data,
	input  var logic unsigned 		 RegWrite,
	input  var logic unsigned 		 clk
);
var logic unsigned [31:0] Registers [31:0];
	always_comb begin
		fpga = Registers [5];
	end

	always_comb begin 
			Read_data1            = Registers[Read_reg1];
			Read_data2            = Registers[Read_reg2];
	end
						
	always_ff @(negedge clk) begin
		Registers[0]		     <= 32'd0;
		if (RegWrite && Write_reg != 0) begin // Fix: Prevent writing to register 0
			Registers[Write_reg] <= Write_data;
		end
	end

endmodule