module Data_Register(
    input  logic       clk,
    input  logic       reset,
    input  logic [9:0] data_in,
    input  logic       get,
    output logic [9:0] data_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 10'b0;
        end
        else if (get) begin
            data_out <= data_in;
        end
        else begin
            data_out <= data_in;
        end
    end
endmodule