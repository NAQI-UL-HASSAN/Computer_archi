module LSU_controller(
    input  var logic [ 6:0] opcode,
    input  var logic [31:0] address,
    input  var logic        get,
    input  var logic        clk,
    input  var logic        rst,
    output var logic        pipe_en,
    output var logic        write,
    output var logic        read,
    output var logic        mem,
    output var logic        uart
);

    always_comb begin
        if      ((opcode == 7'b0000011) && (uart == 1'b1) && (get == 1'b0)) begin
            pipe_en = 1'b0;
        end

        else if ((opcode == 7'b0000011) && (get == 1'b1)) begin
            pipe_en = 1'b1;
        end

        else begin
            pipe_en = 1'b1;
        end
    end

    always_comb begin
        case (opcode)
            7'b0100011: begin
                write = 1;
                read  = 0;
                if (address[11:8] ==  4'd4) begin
                    mem  = 0;
                    uart = 1;
                end
                else begin
                    mem  = 1;
                    uart = 0;
                end

            end

            7'b0000011: begin
                write = 0;
                read  = 1;
                if (address[11:8] ==  4'd4) begin
                    mem  = 0;
                    uart = 1;
                end
                else begin
                    mem  = 1;
                    uart = 0;
                end
            end

            default: begin
                write = 0;
                read  = 0;
                mem  = 0;
                uart = 0;
            end
        endcase
    end

endmodule