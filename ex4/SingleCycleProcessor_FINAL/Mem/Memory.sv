module Memory (
    input  var logic [31:0] out_add,
    input  var logic        clk,
    input  var logic        memw, 
    input  var logic        memr,
    input  var logic [31:0] alu_out,
    input  var logic [31:0] rd2,
    output var logic [31:0] data_out,
    output var logic [31:0] inst,
    output var logic [31:0] datamemory36
);

InstructionMemory Inst_Mem ( .Instruction_address (out_add),
	                         .Instruction         (inst)
                           );

DataMemory        Data_Mem ( .clk                 (clk),
                             .MemWrite            (memw), 
                             .MemRead             (memr),
                             .address             (alu_out),
                             .writeData           (rd2),
                             .readData            (data_out),
                             .datamemory36        (datamemory36)
                           );

endmodule