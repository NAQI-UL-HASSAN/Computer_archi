class baz;
    rand bit a;
    rand bit b;
endclass

module controller_load_tb;
    logic reset;
    logic clk;
    logic fe;
    logic done;
    logic baud_clk_16;
    logic load;

    controller_load DUT(.*);

    task test_load;
        baz x;
        x            = new();
        x.randomize();

        fe = x.a;
        done = x.b;
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
            test_load();
            #10;
        end
        #10;
    end

endmodule