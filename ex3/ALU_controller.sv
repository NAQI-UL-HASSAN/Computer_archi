module ALU_Control
(
	input  var logic unsigned [1 : 0] ALUOp,
	input  var logic unsigned [31:25] inst_Func7,
	input  var logic unsigned [14:12] inst_Func3,
	output var logic unsigned [3 : 0] operation
);

	always_comb begin
	
		if      (ALUOp == 2'b00)   begin
			operation = 4'b0010;
		end
		else if (ALUOp[0] == 1'b1) begin
			operation = 4'b0110;
		end
		else if (ALUOp[1] == 1'b1)&&(inst_Func7 == 7'b0)&&(inst_Func3 == 3'b0) begin
			operation = 4'b0010;
		end
		else if (ALUOp[1] == 1'b1)&&(inst_Func7 == 7'b0100000)&&(inst_Func3 == 3'b0)   begin
			operation = 4'b0110;
		end
		else if (ALUOp[1] == 1'b1)&&(inst_Func7 == 7'b0)&&(inst_Func3 == 3'b111) begin
			operation = 4'b0000;
		end
		else if (ALUOp[1] == 1'b1)&&(inst_Func7 == 7'b0)&&(inst_Func3 == 3'b110) begin
			operation = 4'b0001;
		end
	
	end

endmodule