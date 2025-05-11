module PipelineProcessor(
    input  var logic        clk,
    input  var logic        rst,
    output var logic        rx_clk,
    output var logic        tx_clk,
    output var logic [31:0] pc_out_A,
    output var logic [31:0] IM_out_A,
    output var logic [31:0] IM_out_B,
    output var logic [31:0] regFile_addr,
    output var logic [31:0] rd2_B,        //regfile read data2
    output var logic        pipe_en,
    output var logic        Ff,
    output var logic        Fe,
    output var logic        Rxff,
    output var logic        rd_flag,
    output var logic [ 9:0] uart_out,
    output var logic [ 7:0] uart_in,
    output var logic        Get,
    output var logic        busy,
    output var logic        done_t,
    output var logic        done_r,
    output var logic [31:0] m3_out       //alu_dm_mux (m3)
);
     var logic [ 6:0] inst_control;
     var logic [ 9:0] inst_alu;
    //A

     var logic [31:0] m1_out_A;     //branch_pc_mux (m1)
     var logic [31:0] add4_out_A;   //Add2 Output

    //B

     var logic [31:0] pc_out_B;
     var logic [31:0] immgen_out_B; //imm gen output

     var logic [31:0] m2_out_B;     //regFile_immGen_mux output (m2)
     var logic [31:0] rd1_B;        //regfile read data1
     var logic [31:0] add_out_B;    //Add Output
     var logic [31:0] ALU_out_B;
     var logic        zero_flag;
    //C
     var logic [31:0] DM_addr;
     var logic [31:0] DM_data;      //regfile read data2

     var logic [31:0] DM_out;       //datamemory out


wire logic        sel;
wire logic        alu_src;
wire logic        regwq;
wire logic        memwq;
wire logic        memrq;
wire logic        mem2regq;
wire logic [ 3:0] alu_op;
var  logic        flush;
always_comb begin
    if (sel == 1'b1) begin
        flush = 1'b1;
    end
    else begin
        flush = 1'b0;
    end
end

pipeline_datapathLSU   DATAPATH   ( .clk               (clk),
                                    .rst               (rst),                         
                                    .inst_control      (inst_control),
                                    .inst_alu          (inst_alu),
                                    //CONTROL signals
                                    .sel               (sel),
                                    .alu_src           (alu_src),
                                    .regwq             (regwq),
                                    .memwq             (memwq),
                                    .memrq             (memrq),
                                    .mem2regq          (mem2regq),
                                    .alu_op            (alu_op),
                                    .flush             (flush),
                                    //A
                                    .out_addr          (pc_out_A),
                                    .in_addr           (m1_out_A),
                                    .add4_out          (add4_out_A),
                                    .instd             (IM_out_A),
                                    //B
                                    .instq             (IM_out_B),
                                    .pcq               (pc_out_B),
                                    .imm               (immgen_out_B),
                                    .rd2               (rd2_B),
                                    .a2                (m2_out_B),
                                    .rd1               (rd1_B),
                                    .sum               (add_out_B),
                                    .alu_resultd       (ALU_out_B),
                                    .zero_flag         (zero_flag),
                                    //C
                                    .alu_resultq       (DM_addr),
                                    .rd2q              (DM_data),
                                    .instq1            (regFile_addr),
                                    .data_out          (DM_out),
                                    .a1                (m3_out),
                                    .Ff                (Ff),
                                    .Fe                (Fe),
                                    .Rxff              (Rxff),
                                    .rd_flag           (rd_flag),
                                    .uart_out          (uart_out),
                                    .uart_in           (uart_in),
                                    .Get               (Get),
                                    .busy              (busy),
                                    .tx_clk            (tx_clk),
                                    .done_t            (done_t),
                                    .done_r            (done_r),
                                    .rx_clk            (rx_clk),
                                    .pipe_en           (pipe_en)
                                  );

pipeline_controller    CONTROLLER (.*);
endmodule