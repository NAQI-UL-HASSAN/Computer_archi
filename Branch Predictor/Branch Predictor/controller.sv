module controller (
    input  var logic        clk,
    input  var logic        rst,
    input  var logic [31:0] pc1,              // fetch stage
    input  var logic [31:0] instq1,           // memory stage
    input  var logic        branch,           // branch of PIPELINE
    input  var logic        actual,           // sel of PIPELINE in D/E
    input  var logic        actual1,          // sel of PIPELINE in M/WB
    input  var logic [ 1:0] prediction,       // from BHT
    input  var logic        read,             // from BHT
    output var logic        flush,            // to PIPELINE 
    output var logic [ 1:0] m1_sel,           // to PIPELINE 
    output var logic [ 1:0] updated_logic,    // to BHT 
    output var logic        write             // to BHT 
);

    var logic [1:0] STRONG_NT;
    var logic [1:0] WEAK_NT;
    var logic [1:0] WEAK_T;
    var logic [1:0] STRONG_T;
    var logic [1:0] current_state;
    var logic [1:0] next_state;

//WRITE SIGNAL TO BHT
    always_ff @(posedge clk) begin  
        if (rst) begin
            write             <= 0;
        end 

        else begin
            write             <= read;
        end
    end

//FLUSH SIGNAL TO PIPELINE
    always_comb begin
        if (branch) begin
            if (prediction[1] != actual) begin
                flush          = 1'b1;
            end

            else begin
                flush          = 1'b0;
            end
        end

        else begin
            flush              = 1'b0;
        end
    end

//SELECTION FROM MUX BEFORE PC TO PIPELINE
    always_comb begin
        if (read) begin
            m1_sel             = 2'd2;
        end

        else if (branch) begin
            m1_sel             = 2'd1;
        end

        else if (instq1[6:0] == 7'b1100011) begin
            if (actual1 && prediction[1] == 0) begin
                m1_sel         = 2'd0;
            end

            else begin
                m1_sel         = 2'd1;
            end
        end

        else begin
            m1_sel             = 2'd1;
        end
    end

//UPDATED PREDICTION TO BHT
    //FSM
    logic [1:0] SNT            = 2'b00; 
    logic [1:0] WNT            = 2'b01; 
    logic [1:0] WT             = 2'b10; 
    logic [1:0] ST             = 2'b11;
    logic [1:0] CS, NS;

    always_ff@(posedge clk or posedge rst)   // FF
    begin
        if (rst) CS           <= WNT;

        else     CS           <= NS;
    end

    always_comb begin                        // NEXT STATE LOGIC
        case (prediction)
            SNT: begin
                if (actual)
                    NS         = WNT;

                else
                    NS         = SNT;
            end

            WNT: begin
                if (actual)
                    NS         = ST;

                else
                    NS         = SNT;
            end

            WT: begin
                if (actual)
                    NS         = ST;

                else
                    NS         = SNT;
            end

            ST: begin
                if (actual)
                    NS         = ST;

                else
                    NS         = WT;
            end

            default: NS = WNT;
        endcase
    end

    always_comb begin                        // OUTPUT LOGIC
        case(NS)
            SNT: updated_logic = 2'b00;

            WNT: updated_logic = 2'b01;

            WT : updated_logic = 2'b10;

            ST : updated_logic = 2'b11;

            default: updated_logic = 2'b01;
        endcase
    end
endmodule