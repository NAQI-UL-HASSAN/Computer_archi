class baz;
    rand bit [7:0] a;
endclass

module FIFO_tb;
    logic       clk;
    logic       reset;
    logic [7:0] input_data;
    logic       write_en;
    logic       read_en;
    logic [7:0] output_data;
    logic       fifo_empty;
    logic [4:0] count;
    logic       fifo_full;

    FIFO DUT(.*);

    task test_FIFO;
        baz x;
        x            = new();
        x.randomize();

        input_data = x.a;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        write_en = 0;
        read_en = 0;
        #5;
        reset = 0;
        #5;
        write_en = 1;
        #10;

        for (int i = 0; i < 5; i++) begin
            test_FIFO();
            #10;
        end

        write_en = 0;
        #10;
        read_en = 1;
        #10;
        read_en = 0;
        #20;
        read_en = 1;
    end
endmodule