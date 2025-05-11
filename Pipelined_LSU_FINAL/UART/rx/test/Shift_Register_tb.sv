module Shift_Register_tb;
    logic       reset;
    logic       clk;
    logic       data_in;
    logic       shift_in;
    logic       sel;
    logic       baud_clk;
    logic       done;
    logic [7:0] data_out;
    logic [4:0] count;
    logic [3:0] Count;

    Shift_Register DUT(.*);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task test_shift_register(frame);
        for (int j = 0; j < 16; j++) begin       //to repeat each bit 16 times 
            @(posedge baud_clk); 
                data_in = frame; 
            end
    endtask

    initial begin
        reset = 1; 
        #100; 
        reset = 0;
        sel = 0; 
 
        @(posedge baud_clk); 
        test_shift_register(1); 
        @(posedge baud_clk); 
        test_shift_register(1); 
        @(posedge baud_clk); 
        test_shift_register(1); 
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(0); 
        sel = 1; 
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(0);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(0);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(0);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        sel = 0;
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);  
        @(posedge baud_clk); 
        test_shift_register(1);   
    end

endmodule

