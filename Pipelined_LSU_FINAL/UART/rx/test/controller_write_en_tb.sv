module controller_write_en_tb;
    logic reset;
    logic clk;
    logic done;
    logic enable;

    controller_write_en DUT(.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 0;
        #20;
        
        reset = 1;
        done = 0;
        #10;
        reset = 0;
        #10;
        done = 1;
        #100;
        done = 0;
        
        end

endmodule