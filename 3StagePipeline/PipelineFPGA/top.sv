module top;
    logic        clk;
    logic [31:0] fpga;
    logic        rst;

    PipelineProcessor    DUT1 (.*);
    PipelineProcessor_tb DUT2 (.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

endmodule