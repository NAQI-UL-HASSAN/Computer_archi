module baud_clk_gen (
    input  logic clk,
    input  logic reset,
    input  logic [15:0]brd,
    output logic baud_clk
);
// Reciever clk
//SYSCLK/(BRD/16)

// Baud Div = 8
// 8-1/2 = 3.5
    logic [ 1:0] counter;
    logic [15:0] dumm;
    logic [ 1:0] value;      
    always_comb begin
        dumm = brd >> 4;
        value = (dumm-1) >>1;
    end
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter  <= 0;
            baud_clk <= 0; 
        end
        else begin 
            if (counter == value) begin
                counter  <= 0;
                baud_clk <= ~baud_clk;  
            end
            else begin
                counter  <= counter + 1;
            end
        end
    end
endmodule