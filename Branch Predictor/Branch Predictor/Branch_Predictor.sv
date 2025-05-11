module Branch_Predictor(
    input  logic        clk,
    input  logic        rst,
    input  logic        sel,
    input  logic        sel1,
    input  logic [31:0] pc_fetch,
    input  logic [31:0] pc_execute,
    input  logic [31:0] inst,
    input  logic [31:0] instq1,
    input  logic        branch,
    input  logic [31:0] target_address,
    output logic        flush,
    output logic [ 1:0] m1_sel,
    output logic [31:0] pc_in,
    output logic        write,
    output logic [ 1:0] updated_logic,
    output logic [ 1:0] prediction,
    output logic        read
); 

    BHT        bht (
        .clk           (clk),
        .rst           (rst),
        .write         (write),
        .pc1           (pc_fetch),
        .pc2           (pc_execute),
        .inst          (inst),
        .updated_logic (updated_logic),
        .prediction    (prediction),
        .read          (read)
    );

    BTB        btb (
        .clk           (clk),
        .rst           (rst),
        .read          (read),
        .pc1           (pc_fetch),
        .pc2           (pc_execute),
        .target_address(target_address),
        .actual        (sel),
        .prediction    (prediction),
        .pc_in         (pc_in)
    );

    controller ctrl(
        .clk           (clk),
        .rst           (rst),
        .pc1           (pc_fetch),
        .instq1        (instq1),
        .actual1       (sel1),
        .branch        (branch),
        .actual        (sel),
        .prediction    (prediction),
        .read          (read),
        .flush         (flush),
        .m1_sel        (m1_sel),
        .updated_logic (updated_logic),
        .write         (write)
    );
endmodule