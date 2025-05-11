module top;
    var logic        clk;
    var logic        rst;
    //A
    var logic [31:0] m1_out_A;     //branch_pc_mux (m1)
    var logic [31:0] IM_out_A;
    //B
    var logic [31:0] IM_out_B;
    var logic [31:0] pc_out_B;
    var logic [31:0] ALU_out_B;
    var logic        zero_flag;
    //C
    var logic [31:0] DM_addr;
    var logic [31:0] DM_data;      //regfile read data2
    var logic [31:0] regFile_addr;

    PipelineProcessor    DUT1 (.*);
    PipelineProcessor_tb DUT2 (.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $readmemh("InstructionMemory.txt",DUT1.DATAPATH.Inst_Mem.memory);
    end

endmodule