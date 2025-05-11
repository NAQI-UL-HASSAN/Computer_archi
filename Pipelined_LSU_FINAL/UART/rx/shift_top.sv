module shift_top(
    input  logic       clk,
    input  logic       reset,
    input  logic       rx_data,
    input  logic [15:0]brd,   
    output logic       Shift,
    output logic       done,
    output logic [7:0] output_data,
    output logic       baud_clk,      //for simulation
    output logic [3:0] count_rep,     //  # of repeated bits 
    output logic [3:0] count_bits     // # no bits in shift reg
);


wire Out_mux;
wire Sel;

controller_sel   controller_sel (.clk     (clk),
                                 .reset   (reset),
                                 .Count   (count_bits),
                                 .sel     (Sel)
                                );

mux_r              mux_r        (.in      (rx_data),
                                 .sel     (Sel),
                                 .out     (Out_mux)
                                );

sampler         sampler        (.clk      (clk),
                               .reset     (reset),
                               .in_data   (rx_data),
                               .en        (en),
                               .out_mux   (Out_mux),
                               .shift     (Shift),
                               .baud_clk  (baud_clk),
                               .counter   (count_rep),
                               .brd       (brd)
                               );

Shift_Register  Shift_Register(.reset     (reset),
                               .clk       (clk),
                               .data_in   (rx_data),
                               .shift_in  (Shift),
                               .done      (done),
                               .data_out  (output_data),
                               .count     (count_bits),
                               .brd       (brd)
                               );


endmodule