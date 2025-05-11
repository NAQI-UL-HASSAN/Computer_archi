class baz;
    rand bit a;
    rand bit b;
endclass

module controller_write_en_tb;
    logic reset;
    logic clk;
    logic busy;
    logic ff;
    logic write_en;

    controller_wr_en DUT(.*);

    task test_write_en;
        baz x;
        x            = new();
        x.randomize();

        ff = x.a;
        busy = x.b;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10;
        reset = 0;
        #10;

        for (int i = 0; i < 10; i++) begin
            test_write_en();
            #10;
        end
        #10;
    end

endmodule