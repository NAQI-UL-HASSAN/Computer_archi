module shift_top_tb;
    logic       clk;
    logic       reset;
    logic       rx_data;
    logic       Shift;
    logic       done;
    logic [7:0] output_data;
    logic       baud_clk;
    logic [3:0] count_rep;     //  # of repeated bits 
    logic [3:0] count_bits;     // # no bits in shift reg

    shift_top DUT(.*);

    task test_shift(input bit [13:0] frame);
        for (int i = 0; i < 14; i++) begin
            for (int j = 0; j < 16; j++) begin       
                @(posedge baud_clk); 
                rx_data = frame[i]; 
                $display("mux out = %b, sel = %b", DUT.Out_mux, DUT.Sel);
            end
        end
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

        test_shift(14'b11101101011011);

        #20;
        test_shift(14'b11101110011011);
        #20;


    end
endmodule