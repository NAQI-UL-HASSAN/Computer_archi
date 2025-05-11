module InstructionMemory (
	input  var logic [31:0] Instruction_address,
	output var logic [31:0] Instruction
);

	var logic [31:0] memory [15:0];

	always_comb begin
		memory[0] = 32'h02500193;
		memory[1] = 32'h02000513;
		memory[2] = 32'h00a1f0b3;
		memory[3] = 32'h00a52223;
		memory[4] = 32'h00452483;
		memory[5] = 32'h00a50663;
		memory[6] = 32'h003562b3;
		memory[7] = 32'h01500793;
		memory[8] = 32'h403502b3;
	end
	
	always_comb begin
		Instruction    = memory[Instruction_address/4];
	end
	
endmodule