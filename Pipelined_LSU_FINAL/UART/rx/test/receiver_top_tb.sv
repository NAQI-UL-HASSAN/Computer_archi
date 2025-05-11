module receiver_top_tb;
    logic       clk;
    logic       rst;
    logic       Get;
    logic       Rx_input;
    logic       Shift;
    logic       baud_clk;      //for simulation
    logic [3:0] count_rep;     
    logic [3:0] count_bits; 
    logic [7:0] sf_data;
    logic [9:0] fd_data;  
    logic       Done;
    logic       en_f;
    logic [9:0] Rx_out;
    logic       Rxff;          

    receiver_top DUT(.*);

        task test_receiver (input bit [11:0] frame);
        for (int i = 0; i < 12; i++) begin
            for (int j = 0; j < 16; j++) begin       
                @(posedge baud_clk); 
                Rx_input = frame[i]; 
                $display("fifo enable = %b", DUT.en_f);
            end
        end
    endtask

        initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        Get = 0;
        #30;

        rst = 0;
        #10;

        test_receiver(12'b101101011011);
        $display("output of shift reg = %h", DUT.receiver.sf_data);
        #10;

        @(posedge clk);
        if (Done) begin
            Get = 1;
        end
        @(posedge clk);
        $display("output of fifo = %h", DUT.receiver.fd_data);
        Get  = 0;

    end

endmodule