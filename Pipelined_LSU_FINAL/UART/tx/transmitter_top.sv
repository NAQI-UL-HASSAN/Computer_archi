module transmitter_top(
    input  logic       clk,
    input  logic       rst,
    input  logic [7:0] data_in,
    input  logic       busy,
    input  logic [15:0]brd,
    output logic       out_tx,
    output logic [7:0] data_df,
    output logic [7:0] data_fs,
    output logic       en_w,
    output logic       en_read,
    output logic [4:0] Count,
    output logic       Load,
    output logic       Fe,
    output logic       Ff,
    output logic       Done,
    output logic       tx_clk
);

transmitter         transmitter         (.clk      (clk),
                                         .rst      (rst),
                                         .data_in  (data_in),
                                         .data_df  (data_df),
                                         .data_fs  (data_fs),
                                         .busy     (busy),
                                         .write_en (en_w),
                                         .read_en  (en_read), 
                                         .count    (Count), 
                                         .load     (Load),
                                         .fifo_empty(Fe),
                                         .fifo_full(Ff),
                                         .done     (Done),
                                         .tx_clk   (tx_clk),
                                         .out_tx   (out_tx),
                                         .brd      (brd)
                                         );

controller_load     controller_load     (.clk      (clk),
                                         .reset    (rst),
                                         .fe       (Fe),
                                         .done     (Done),
                                         .load     (Load),
                                         .brd      (brd)
                                         );

controller_wr_en    controller_wr_en    (.clk      (clk),
                                         .reset    (rst),
                                         .busy     (busy),
                                         .ff       (Ff),
                                         .write_en (en_w)
                                         );

controller_fout     controller_fout     (.clk      (clk),
                                         .reset    (rst),
                                         .load     (Load),
                                         .f_out    (en_read)
                                         );
endmodule 
