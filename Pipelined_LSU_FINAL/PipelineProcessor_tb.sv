module PipelineProcessor_tb(
    output var logic        rst,
    input  var logic        clk,
    input  var logic        rx_clk,
    input  var logic        tx_clk,
    input  var logic [31:0] pc_out_A,
    input  var logic [31:0] IM_out_A,
    input  var logic [31:0] IM_out_B,
    input  var logic [31:0] regFile_addr,
    input  var logic [31:0] rd2_B,        //regfile read data2
    input  var logic        pipe_en,
    input  var logic        Ff,
    input  var logic        Fe,
    input  var logic        Rxff,
    input  var logic        rd_flag,
    input  var logic [ 9:0] uart_out,
    input  var logic [ 7:0] uart_in,
    input  var logic        Get,
    input  var logic        busy,
    input  var logic        done_t,
    input  var logic        done_r,
    input  var logic [31:0] m3_out       //alu_dm_mux (m3)
);

initial begin
    rst = 1'b1;
    @(posedge clk); rst <= 1'b0;
    #35;
    $display("Register 1 has: %h", DUT1.DATAPATH.Reg_file.Registers[1]); //addi
    #35;
    $display("Register 2 has: %h", DUT1.DATAPATH.Reg_file.Registers[2]); //addi
    #35;
    $display("Register 3 has: %h", DUT1.DATAPATH.Reg_file.Registers[3]); //addi
    #35;
    $display("UART BRD has: %h", DUT1.DATAPATH.LSU.LSU_datapath.uart_baud_reg); //sw
    #35;
    $display("UART TX has: %h", DUT1.DATAPATH.LSU.LSU_datapath.uart_tx_reg); //sw
    #35;
    $display("UART RX has: %h", DUT1.DATAPATH.LSU.LSU_datapath.uart_rx_reg); //lw
    $display("Register 4 has: %h", DUT1.DATAPATH.Reg_file.Registers[4]); //lw


end

endmodule