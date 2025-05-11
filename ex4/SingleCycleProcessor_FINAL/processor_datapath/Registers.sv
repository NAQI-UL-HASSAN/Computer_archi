module Registers (
	output var logic unsigned [31:0] Read_data1,
	output var logic unsigned [31:0] reg3,
	output var logic unsigned [31:0] reg10,
	output var logic unsigned [31:0] reg1,
	output var logic unsigned [31:0] reg9,
	output var logic unsigned [31:0] reg5,
 	output var logic unsigned [31:0] Read_data2,
	input  var logic unsigned [ 4:0] Read_reg1,
	input  var logic unsigned [ 4:0] Read_reg2,
	input  var logic unsigned [ 4:0] Write_reg,
	input  var logic unsigned [31:0] Write_data,
	input  var logic unsigned 		 RegWrite,
	input  var logic unsigned 		 clk
);

	var logic unsigned [31:0] Registers [31:0];

	always_comb begin
		reg3  = Registers[3];
		reg10 = Registers[10];
		reg1  = Registers[1];
		reg9  = Registers[9];
		reg5  = Registers[5];
	end

	always_comb begin 
			Read_data1            = Registers[Read_reg1];
			Read_data2            = Registers[Read_reg2];
	end
						
	always_ff @(posedge clk) begin
		Registers[0]		     <= 32'd0;
		if (RegWrite && Write_reg != 0) begin // Fix: Prevent writing to register 0
			Registers[Write_reg] <= Write_data;
		end
	end

endmodule