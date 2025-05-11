class baz;
    rand bit [7:0] a;
endclass

module transmitter_top_tb;
    logic       clk;
    logic       rst;
    logic [7:0] data_in;
    logic       busy;
    logic       out_tx;
    logic [7:0] data_df;
    logic [7:0] data_fs;
    logic       en_w;
    logic       en_read;
    logic [4:0] Count;
    logic       Load;
    logic       Fe;
    logic       Ff;
    logic       Done;
    logic       tx_clk;

    transmitter_top DUT(.*);

    task test_transmitter_top();
        baz x;
        x            = new();
        x.randomize();

        data_in = x.a;
        busy = 1;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;
        #10;

        test_transmitter_top();
        @(posedge clk);
        busy = 0;
        #50;

        test_transmitter_top();
        #5;
        @(posedge clk);
        busy = 0;
        #50;

        test_transmitter_top();
        #5;
        @(posedge clk);
        busy = 0;
        #50;

        test_transmitter_top();
        #5;
        @(posedge clk);
        busy = 0;
        #50;
    end
endmodule