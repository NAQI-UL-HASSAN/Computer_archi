module data_register_t(
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] data_in,
    input  logic       busy,
    output logic [7:0] data_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out = 8'b0;
        end
        else if (busy) begin
            data_out = data_in;
        end
    end
endmodule