module BHT (
    input  var logic        clk,
    input  var logic        rst,
    input  var logic        write,            // from controller
    input  var logic [31:0] pc1,              // fetch stage
    input  var logic [31:0] pc2,              // execute stage
    input  var logic [31:0] inst,             // fetched instruction
    input  var logic [ 1:0] updated_logic,
    output var logic [ 1:0] prediction,
    output var logic        read
);
    var logic [23:0] bht [0:255];             // total 256 ( 22 bits TAG + 2 bits prediction logic )
    var logic [21:0] tag1;                    // fetch stage
    var logic [ 7:0] index1;                  // fetch stage
    var logic [21:0] tag2;                    // execute stage
    var logic [ 7:0] index2;                  // execute stage

//READ LOGIC
    always_comb begin
        if (inst[6:0] == 7'b1100011) begin
            read               = 1'b1;
        end

        else begin
            read               = 1'b0;
        end
    end

//ASSIGN TAG AND INDEX
    always_comb begin
        if (read) begin
            tag1               = pc1[31:10];
            index1             = pc1[ 9: 2];
        end

        if (write) begin
            tag2               = pc2[31:10];
            index2             = pc2[ 9: 2];
        end
    end

//PREDICTION
    always_comb begin
        if (read) begin
            if (tag1 == bht[index1][23:2]) begin
                prediction     = bht[index1][1:0];
            end

            else begin                        // missed (means new branch)
                prediction     = 2'b01;       // weakly not taken
            end 
        end
        
        //ELSE DO WE CARE?? NO!
    end 

//UPDATE
    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 256; i++) begin
                bht[i][23:2]  <= 22'bx;
                bht[i][ 1:0]  <= 2'bx;
            end
        end

        else if (write) begin
            bht[index2][23:2] <= tag2;
            bht[index2][ 1:0] <= updated_logic;
        end
    end
endmodule