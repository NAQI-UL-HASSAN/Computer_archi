class baz;
    rand bit [7:0] a;
endclass

module fifo_tb;
    logic       clk;
    logic       reset;
    logic [7:0] data;
    logic       write_en;
    logic       get;
    logic       frame_error;
    logic       overrun_error;
    logic [9:0] out_data;
    logic [4:0] count;
    logic       RXFF;

    fifo DUT(.*);

    task test_FIFO;
        baz x;
        x            = new();
        x.randomize();

        data = x.a;
        #1;

    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        write_en = 0;
        get = 0;
        #5;
        reset = 0;
        #5;
        write_en = 1;
        #10;

        for (int i = 0; i < 10; i++) begin
            test_FIFO();
            #10;
        end

        write_en = 0;
        #10;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        get = 1;
        @(posedge clk);
        get = 0;
    end

endmodule
