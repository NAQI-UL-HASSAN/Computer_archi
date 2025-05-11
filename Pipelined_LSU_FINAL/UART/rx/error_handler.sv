module error_handler(
    input  var logic RxFF,
    input  var logic stop_bit,
    output var logic overrun_error,
    output var logic frame_error
);

    always_comb begin
        if ((RxFF && stop_bit)) begin   
            overrun_error = 1'b1;
        end
        else begin
            overrun_error = 1'b0;
        end

        if (!stop_bit) begin             //en is done signal from shift reg which is asserted if stop bit is detected
            frame_error   = 1'b1;
        end
        else begin
            frame_error   = 1'b0;
        end
    end

endmodule