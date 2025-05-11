class baz;
    rand bit [3:0] a;
endclass

module controller_sel_tb;
    logic       clk;
    logic       reset;
    logic [3:0] Count1;   //# of bits in shift reg
    logic       sel ;

    controller_sel DUT(.*);

    task test_controller();
        baz x;
        x            = new();
        x.randomize();

        Count1 = x.a;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10;
        reset = 0;

        Count1 = 4'd3;
        #30;

        Count1 = 4'd10;
        #30;

        Count1 = 4'd1;
        #30;

        Count1 = 4'd7;
        #30;

        Count1 = 4'd2;
        #30;

        Count1 = 4'd1;
        #30;

        Count1 = 4'd6;
        #30;

        Count1 = 4'd9;
        #30;
        
    end

endmodule