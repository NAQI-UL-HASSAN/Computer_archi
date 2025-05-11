module baud_rate_gent (
    input  logic baud_clk,
    input  logic reset,
    output logic baud_clk_16
);
// Baud Div = 16
// 16-1/2 = 7.5
    logic [2:0] counter;

    always_ff @(posedge baud_clk or posedge reset) begin
        if (reset) begin
            counter     <= 0;
            baud_clk_16 <= 0; 
        end
        else begin 
            if (counter == 7) begin
                counter     <= 0;
                baud_clk_16 <= ~baud_clk_16;  
            end
            else begin
                counter <= counter + 1;
            end
        end
    end
endmodule