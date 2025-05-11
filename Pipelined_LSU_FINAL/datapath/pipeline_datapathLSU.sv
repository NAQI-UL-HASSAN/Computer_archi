module pipeline_datapathLSU(
    input  var logic        clk,
    input  var logic        rst,
    input  var logic        sel,
    input  var logic        alu_src,
    input  var logic        regwq,
    input  var logic        memwq,
    input  var logic        memrq,
    input  var logic        mem2regq,
    input  var logic        flush,
    input  var logic [ 3:0] alu_op,
    output var logic [31:0] out_addr,
    output var logic [31:0] in_addr,    //branch_pc_mux (m1)
    output var logic [31:0] add4_out,  //Add2 Output
    output var logic [31:0] instd,
    output var logic [31:0] instq,
    output var logic [31:0] pcq,
    output var logic [31:0] imm,       //imm gen output
    output var logic [31:0] rd2,       //regfile read data2
    output var logic [31:0] a2,        //regFile_immGen_mux output (m2)
    output var logic [31:0] rd1,       //regfile read data1
    output var logic [31:0] sum,       //Add Output
    output var logic [31:0] alu_resultd,
    output var logic [31:0] alu_resultq,
    output var logic [31:0] rd2q,      //regfile read data2
    output var logic [31:0] instq1,
    output var logic [31:0] data_out,  //datamemory out
    output var logic [31:0] a1,        //alu_dm_mux (m3)
    output var logic [ 6:0] inst_control,
    output var logic [ 9:0] inst_alu,
    output var logic        zero_flag,
    output var logic        Ff,
    output var logic        Fe,
    output var logic        Rxff,
    output var logic        rd_flag,
    output var logic [ 9:0] uart_out,
    output var logic [ 7:0] uart_in,
    output var logic        Get,
    output var logic        busy,
    output var logic        tx_clk,
    output var logic        done_t,
    output var logic        rx_clk,
    output var logic        done_r,
    output var logic        pipe_en
);

logic [31:0] dummy;  //datamemory out

always_comb begin
    inst_control = instq[6:0];
    inst_alu     = {instq[31:25], instq[14:12]};
end

//FETCH stage
PC                PC       ( .clk                 (clk),
                             .rst                 (rst),
                             .in_address          (in_addr),
                             .out_address         (out_addr),
                             .pipe_en             (pipe_en)
                           );

Add2              Add2     ( .operand111          (out_addr),
                             .Sum1                (add4_out),
                             .pipe_en             (pipe_en)
                           );

Mux               m1       ( .in1                 (add4_out),
                             .in2                 (sum),
                             .out                 (in_addr),
                             .MemtoReg            (sel)
                           );  

InstructionMemory Inst_Mem ( .Instruction_address (out_addr),
	                           .Instruction         (instd)
                           );

IF_ID             IF_ID    ( .clk                 (clk),
                             .rst                 (rst),
                             .en                  (pipe_en),
                             .instd               (instd),
	                           .pcd                 (out_addr),
                             .instq               (instq),
	                           .pcq                 (pcq),
                             .flush               (flush)
                           );

//DECODE and EXECUTE stage

Registers         Reg_file ( .Read_reg1           (instq[19:15]),
                             .Read_reg2           (instq[24:20]),
                             .Write_reg           (instq1[11:7]),
                             .Write_data          (a1),
                             .Read_data1          (rd1),
                             .Read_data2          (rd2),
                             .clk                 (clk),
                             .RegWrite            (regwq)
                    ); 

imm_gen           imm_gen  ( .instruction         (instq),
                             .imm_val             (imm)
                           );

Mux               m2       ( .in1                 (rd2),
                             .in2                 (imm),
                             .out                 (a2),
                             .MemtoReg            (alu_src)
                           ); 

Add               Add      ( .operand11           (pcq),
                             .operand22           (imm),
                             .Sum                 (sum)
                           ); 

ALU               alu      ( .operand1            (rd1),
                             .operand2            (a2),
                             .ALUresult           (alu_resultd),
                             .ALUoperation        (alu_op),
                             .zero                (zero_flag)
                           ); 

LSU               LSU      ( .clk                 (clk),
                             .data_in             (rd2),
                             .rst                 (rst),
                             .address             (alu_resultd),
                             .opcode              (instq[6:0]),
                             .pipe_en             (pipe_en),
                             .Ff                  (Ff),
                             .Fe                  (Fe),
                             .Rxff                (Rxff),
                             .rd_flag             (rd_flag),
                             .uart_out            (uart_out),
                             .get                 (Get),
                             .busy                (busy),
                             .data_out            (data_out),
                             .uart_in             (uart_in),
                             .brd                 (brd)
);   

EX_MEM            EX_MEM   ( .clk                 (clk),
                             .rst                 (rst),
                             .en                  (pipe_en),
                             .alu_resultd         (alu_resultd),
	                           .rd2d                (rd2),
                             .instd1              (instq),
                             .alu_resultq         (alu_resultq),
	                           .rd2q                (rd2q),
                             .instq1              (instq1)
                           );

//MEMORY and WRITEBACK stage

DataMemory        Data_Mem ( .clk                 (clk),
                             .MemWrite            (memwq), 
                             .MemRead             (memrq),
                             .address             (alu_resultq),
                             .writeData           (rd2q),
                             .readData            (dummy)
                           );

Mux               m3       ( .in1                 (alu_resultq),
                             .in2                 (data_out),
                             .out                 (a1),
                             .MemtoReg            (mem2regq)
                           ); 

//UART

UART              UART     (.*);

endmodule