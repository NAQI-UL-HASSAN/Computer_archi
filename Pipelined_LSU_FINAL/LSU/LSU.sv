module LSU (
    input  var logic        clk,
    input  var logic        rst,
    input  var logic [31:0] data_in,
    input  var logic [31:0] address,
    input  var logic [ 6:0] opcode,
    input  var logic        Ff,
    input  var logic        Fe,
    input  var logic        Rxff,
    input  var logic        rd_flag,
    input  var logic [ 9:0] uart_out,
    output var logic        pipe_en,
    output var logic        get,
    output var logic        busy,
    output var logic [31:0] data_out,
    output var logic [ 7:0] uart_in,
    output var logic [15:0] brd
);

logic s1, s2, s3, s4;

LSU_controller LSU_controller (.opcode        (opcode),
                               .address       (address),
                               .get           (get),
                               .pipe_en       (pipe_en),
                               .write         (s1),
                               .read          (s2),
                               .mem           (s3),
                               .uart          (s4),
                               .rst           (rst),
                               .clk           (clk)
                              );

LSU_datapath   LSU_datapath   (.clk           (clk),
                               .data_in       (data_in),
                               .address       (address),
                               .write         (s1),
                               .read          (s2),
                               .mem           (s3),
                               .uart          (s4),
                               .get           (get),
                               .busy          (busy),
                               .data_out      (data_out),
                               .brd           (brd),
                               .Ff            (Ff),
                               .Fe            (Fe),
                               .Rxff          (Rxff),
                               .rd_flag       (rd_flag),
                               .uart_in       (uart_in),
                               .uart_out      (uart_out)
                              );

endmodule