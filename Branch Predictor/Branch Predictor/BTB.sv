module BTB(
    input  var logic        clk,
    input  var logic        rst,
    input  var logic        read,             // from BHT
    input  var logic [31:0] pc1,              // fetch stage
    input  var logic [31:0] pc2,              // execute stage
    input  var logic [31:0] target_address,   // from execute stage
    input  var logic        actual,           // sel of PIPELINE
    input  var logic [1:0]  prediction,       // from BHT
    output var logic [31:0] pc_in             // next address if branch inst
);

    var logic [53:0] btb [255:0];             // total 256 ( 22 bits TAG + 32 bits target address ) 
    var logic [21:0] tag1;                    // fetch stage
    var logic [ 7:0] index1;                  // fetch stage
    var logic [21:0] tag2;                    // execute stage
    var logic [ 7:0] index2;                  // execute stage

//ASSIGN TAG AND INDEX
    always_comb begin
        if (read) begin
            tag1               = pc1[31:10];
            index1             = pc1[9:2]; 
        end

        else begin
            tag2               = pc2[31:10];
            index2             = pc2[9:2]; 
        end
    end

//GET TARGET ADDRESS
    always_comb  begin
        if (read) begin 
            if      ((prediction[1] == 1) && (tag1 == btb[index1][53:32])) begin //predicted taken
                pc_in          = btb[index1][31:0];
            end

            else if ((prediction[1] == 0) && (tag1 == btb[index1][53:32])) begin //predicted not taken
                pc_in          = pc1 + 4;
            end

            else begin
                pc_in          = pc1 + 4;
            end
        end 
    end

//WRITE OR REMOVE
    always_ff @(negedge clk) begin
        if (rst) begin
            for (int i = 0; i < 256; i++) begin
                btb[i][31: 0] <= 32'bx;
                btb[i][53:32] <= 22'bx;
            end
        end

        else if ((actual)) begin
            btb[index2][31:0]  = target_address;
            btb[index2][53:32] = tag2;
        end

        else if ((prediction == 2'b10) && (!actual)) begin
            btb[index2][31:0]  = 32'bx;
            btb[index2][53:32] = 22'bx;
        end

        else if ((prediction == 2'b01) && (!actual)) begin
            btb[index2][31:0]  = 32'bx;
            btb[index2][53:32] = 22'bx;
        end

        else if ((prediction == 2'b00) && (!actual)) begin
            btb[index2][31:0]  = 32'bx;
            btb[index2][53:32] = 22'bx;
        end
    end
endmodule