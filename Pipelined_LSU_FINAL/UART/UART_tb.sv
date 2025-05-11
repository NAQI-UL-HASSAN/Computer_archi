class baz;
    rand bit [7:0] a;
endclass

module UART_tb;
    logic       clk;
    logic       rst;
    logic [7:0] uart_in;
    logic       busy;
    logic       Get;
    logic       tr_data;
    logic [7:0] df_t;
    logic [7:0] fs_t;
    logic       en_w;
    logic       en_read;
    logic [4:0] Count;
    logic       Load;
    logic       Fe;
    logic       Ff;
    logic       done_t;
    logic       tx_clk;
    logic       rd_flag;
    logic       Shift;
    logic       rx_clk;
    logic [3:0] count_rep;
    logic [3:0] count_bits;
    logic [7:0] sf_r;
    logic [9:0] fd_r;
    logic       done_r;
    logic       en_f;
    logic [9:0] uart_out;
    logic       Rxff;
    logic [15:0] brd;

    UART DUT(.*);

    task test_uart();
        baz x;
        x            = new();
        x.randomize();

        uart_in = x.a;
        busy = 1;
        #5;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        Get = 0;
        #10;
        rst = 0;
        #10;

        test_uart();
        @(posedge clk);
        busy = 0;
        #10;

        
        wait (rd_flag == 1);
        Get = 1;
        @(posedge clk);
        Get  = 0;

        //2nd test 
        #1000;
        test_uart();
        @(posedge clk);
        busy = 0;
        #10;

        wait (done_r == 1);
        @(posedge clk);
        Get = 1;
        @(posedge clk);
        Get  = 0;

        //3rd test 
        #1000;
        test_uart();
        @(posedge clk);
        busy = 0;
        #10;

        wait (done_r == 1);
        @(posedge clk);
        Get = 1;
        @(posedge clk);
        Get  = 0;
    end
endmodule