module mux_r (
    input  logic in,
    input  logic sel,
    output logic out
);

    always_comb begin
        case(sel)
            1'b0 : out = 0;
            1'b1 : out = in;
        endcase
    end

endmodule