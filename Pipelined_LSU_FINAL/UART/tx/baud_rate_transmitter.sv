module baud_rate_transmitter(
    input  logic clk,
    input  logic reset,
    input  logic [15:0]brd,
    output logic baud_clk_16
);

logic n1;

baud_clk_gen          baud_clk_gen          (.clk         (clk),
                                             .reset       (reset),
                                             .baud_clk    (n1),
                                             .brd         (brd)
                                            );

baud_rate_gent        baud_rate_gent        (.baud_clk    (n1),
                                             .reset       (reset),
                                             .baud_clk_16 (baud_clk_16)
                                            );

endmodule