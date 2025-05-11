class baz;
    rand bit [9:0] a;
endclass

module data_register_tb;
    logic       clk;
    logic       reset;
    logic       rd_flag;
    logic [9:0] data_in;
    logic [9:0] data_out;

    Data_Register DUT(.*);

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
        #5;
        reset = 0;
        #5;

        for (int i = 0; i < 5; i++) begin
            test_data_register();
            #10;
        end

    end

endmodule
