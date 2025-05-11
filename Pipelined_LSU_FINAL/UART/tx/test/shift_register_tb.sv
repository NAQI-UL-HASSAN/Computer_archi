module shift_register_tb;
    var logic       clk;
    var logic       reset;
    var logic       load;
    var logic [7:0] data_in;
    var logic       baud_clk_16;
    var logic       data_out;
    var logic       done;
        
    shift_register DUT (.*);

    task test_shift_register(input bit [7:0] frame);
        $display("10-bit frame: %b", frame);

        @(posedge baud_clk_16); 
        load = 1; 
        data_in = frame;
        #10; 

    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        load  = 0; 
        #10; 
        
        reset = 0;
        #10;
        
        $display("\nTest case 1:");
        test_shift_register(8'b11011110); 
        #10;
        @(posedge baud_clk_16);
        load = 0; 

        #15000;
        $display("\nTest case 1:");
        test_shift_register(8'b11001010); 
        #10;
        @(posedge baud_clk_16);
        load = 0;    

    end
endmodule