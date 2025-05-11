module imm_gen (
    output var logic unsigned [31:0] imm_val,
    input  var logic unsigned [31:0] instruction
);

    always_comb begin
        if      (instruction[6] == 1'b0) begin                                // Data transfer instruction
            if      (instruction[5] == 1'b0) begin                            // Load instruction
                imm_val = {{20{instruction[31]}}, instruction[31:20]};
            end 
			
			else if (instruction[5] == 1'b1) begin                            // Store instruction
                imm_val = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
        end 
		
		else if (instruction[6] == 1'b1) begin                                // Conditional Branch instruction
                imm_val = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        end 
		
		else begin
                imm_val = 32'b0;                                            // Default if no match
        end
    end
endmodule
