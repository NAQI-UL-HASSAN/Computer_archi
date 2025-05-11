module InstructionMemory (
	input  var logic [31:0] Instruction_address,
	output var logic [31:0] Instruction
);

	var logic [31:0] memory [15:0];
	
	always_comb begin
		Instruction    = memory[Instruction_address/4];
	end
	
endmodule