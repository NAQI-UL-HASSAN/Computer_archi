module Branch_Predictor_tb;

    logic        clk;
    logic        rst;
    logic        sel;
    logic        sel1;
    logic [31:0] pc_fetch;
    logic [31:0] pc_execute;
    logic [31:0] inst;
    logic [31:0] instq1;
    logic        branch;
    logic [31:0] target_address;

    logic        flush;
    logic [ 1:0] m1_sel;
    logic [31:0] pc_in;
    logic        write;
    logic [ 1:0] updated_logic;
    logic [ 1:0] prediction;
    logic        read;

    Branch_Predictor DUT (.*);

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        //PREDICTED WRONG
        @(posedge clk); //BRANCH_1 inst in FETCH
            rst            = 0;
            pc_fetch       = 32'h00000004;
            inst           = 32'h00018a63; //beq x3, x0, label
        
        @(posedge clk); //BRANCH_1 inst in DECODE/EXECUTE
            pc_fetch       = 32'hx;
            inst           = 32'hx;
            pc_execute     = 32'h00000004;
            branch         = 1;
            target_address = 32'h00000014;
            #5; sel        = 1;

        @(posedge clk); //BRANCH_1 inst in MEMORY/WB
            pc_execute     = 32'hx;
            branch         = 1'bx;
            target_address = 32'hx;
            sel            = 1'bx;
            sel1           = 1;
            instq1         = 32'h00018a63;

        @(posedge clk); //MISS KRAO

        //PREDICTED RIGHT
        @(posedge clk); //BRANCH_1 inst in FETCH
            pc_fetch       = 32'h00000004;
            inst           = 32'h00018a63;

        @(posedge clk); //BRANCH_1 inst in DECODE/EXECUTE
            pc_fetch       = 32'hx;
            inst           = 32'hx;
            pc_execute     = 32'h00000004;
            branch         = 1;
            target_address = 32'h00000014;
            #5; sel        = 1;

        @(posedge clk); //BRANCH_1 inst in MEMORY/WB
            pc_execute     = 32'hx;
            branch         = 1'bx;
            target_address = 32'hx;
            sel            = 1'bx;
            sel1           = 1;
            instq1         = 32'h00018a63;

        //NON BRANCH INST
        @(posedge clk); //BRANCH_1 inst in FETCH
            pc_fetch       = 32'h000000014;
            inst           = 32'h00100193; //addi x3, x0, 1
        
        $writememh("Branch_History_Table.txt",DUT.bht.bht);
        $writememh("Branch_Target_Buffer.txt",DUT.btb.btb);
    end
endmodule