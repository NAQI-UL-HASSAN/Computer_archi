module top;
    var logic        rst;
    var logic        clk;
    var logic        rx_clk;
    var logic        tx_clk;
    var logic [31:0] pc_out_A;
    var logic [31:0] IM_out_A;
    var logic [31:0] IM_out_B;
    var logic [31:0] regFile_addr;
    var logic [31:0] rd2_B;        //regfile read data2
    var logic        pipe_en;
    var logic        Ff;
    var logic        Fe;
    var logic        Rxff;
    var logic        rd_flag;
    var logic [ 9:0] uart_out;
    var logic [ 7:0] uart_in;
    var logic        Get;
    var logic        busy;
    var logic        done_t;
    var logic        done_r;
    var logic [31:0] m3_out;       //alu_dm_mux (m3)

    var logic unsigned [31:0] Read_data1;
 	var logic unsigned [31:0] Read_data2;
	var logic unsigned [ 4:0] Read_reg1;
	var logic unsigned [ 4:0] Read_reg2;
	var logic unsigned [ 4:0] Write_reg;
	var logic unsigned [31:0] Write_data;
	var logic unsigned 	      RegWrite;


    PipelineProcessor    DUT1 (.*);
    PipelineProcessor_tb DUT2 (.*);

    Registers UUT (.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $readmemh("InstructionMemory.txt",DUT1.DATAPATH.Inst_Mem.memory);
    end

endmodule