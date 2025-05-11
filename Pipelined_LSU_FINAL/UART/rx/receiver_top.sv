module receiver_top(
    input  logic       clk,
    input  logic       rst,
    input  logic       Get,
    input  logic       Rx_input,
    input  logic [15:0]brd,
    output logic       Shift,
    output logic       baud_clk,      //for simulation
    output logic [3:0] count_rep,     
    output logic [3:0] count_bits,
    output logic [7:0] sf_data,
    output logic [9:0] fd_data,
    output logic       rd_flag,     
    output logic       Done,
    output logic       en_f,
    output logic [9:0] Rx_out,
    output logic       Rxff        
);

        logic       frame_error; 
        logic       overrun_error;
        
receiver            receiver            (.clk           (clk),
                                         .rst           (rst),
                                         .Rx_input      (Rx_input),
                                         .Get           (Get),
                                         .Shift         (Shift),
                                         .baud_clk      (baud_clk),
                                         .count_rep     (count_rep),
                                         .count_bits    (count_bits),
                                         .Done          (Done),
                                         .rd_flag       (rd_flag),
                                         .sf_data       (sf_data),
                                         .fd_data       (fd_data),
                                         .write_en      (en_f),
                                         .Rx_out        (Rx_out),
                                         .Rxff          (Rxff),
                                         .brd           (brd)
                                         );

controller_write_en controller_write_en (.clk           (clk),
                                         .reset         (rst),
                                         .enable        (en_f),
                                         .done          (Done)
                                         );

endmodule