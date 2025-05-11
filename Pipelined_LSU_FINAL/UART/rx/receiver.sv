module receiver (
    input  logic       clk,
    input  logic       rst,
    input  logic       Rx_input,
    input  logic       Get,
    input  logic       write_en,
    input  logic [15:0]brd,  
    output logic       Shift,
    output logic       rd_flag,
    output logic       baud_clk,      //for simulation
    output logic [3:0] count_rep,     
    output logic [3:0] count_bits,   
    output logic       Done,
    output logic [7:0] sf_data,
    output logic [9:0] fd_data,
    output logic [9:0] Rx_out,
    output logic       Rxff          
);
          
          logic [4:0] count;
          logic       overrun_error;
          logic       frame_error;
          

           
shift_top      shift_top      (.clk          (clk),
                              .reset        (rst),
                              .rx_data      (Rx_input),
                              .Shift        (Shift),
                              .done         (Done),
                              .output_data  (sf_data),
                              .baud_clk     (baud_clk),
                              .count_rep    (count_rep),
                              .count_bits   (count_bits),
                              .brd          (brd)
                              );

fifo           fifo           (.clk           (clk),
                               .reset         (rst),
                               .data          (sf_data),
                               .write_en      (write_en),
                               .get           (Get),
                               .overrun_error (overrun_error),
                               .frame_error   (frame_error),
                               .count         (count),
                               .out_data      (fd_data),
                               .rd_flag       (rd_flag),
                               .RXFF          (Rxff)
                                );

Data_Register  Data_Register  (.clk           (clk),
                               .reset         (rst),
                               .data_in       (fd_data),
                               .get           (Get),
                               .data_out      (Rx_out)
                              );

error_handler  error_handler (.RxFF          (Rxff),
                              .stop_bit      (Done),
                              .overrun_error (overrun_error),
                              .frame_error   (frame_error)
                              );                     

endmodule