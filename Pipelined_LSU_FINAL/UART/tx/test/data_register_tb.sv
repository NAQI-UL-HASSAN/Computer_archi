class baz;
    rand bit [7:0] a;
endclass

module data_register_tb;
    logic       clk;
    logic       reset;
    logic [7:0] data_in;
    logic       busy;
    logic [7:0] data_out;

    data_register DUT(.*);

    task test_data_register;
        baz x;
        x            = new();
        x.randomize();

        data_in = x.a;
        
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        busy = 0;
        #5;
        reset = 0;
        #5;
        busy = 1;

        for (int i = 0; i < 5; i++) begin
            test_data_register();
            #10;
        end

    end

endmodule
