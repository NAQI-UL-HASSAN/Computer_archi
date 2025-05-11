module LSU_datapath (
    input  var logic        clk,
    input  var logic [31:0] data_in,
    input  var logic [31:0] address,
    input  var logic        write,
    input  var logic        read,
    input  var logic        mem,
    input  var logic        uart,
    input  var logic        Ff,
    input  var logic        Fe,
    input  var logic        Rxff,
    input  var logic        rd_flag,
    input  var logic [ 9:0] uart_out,
    output var logic        get,
    output var logic [ 7:0] uart_in,
    output var logic        busy,
    output var logic [15:0] brd,
    output var logic [31:0] data_out
);
    // Memory (1KB total)
    logic [3:0][7:0] memory [255:0];

    // UART Registers
    logic [31:0] uart_tx_reg;   //0x0000 0400
    logic [31:0] uart_rx_reg;   //0x0000 0404
    logic [31:0] uart_ctrl_reg; //0x0000 0408
    logic [31:0] uart_baud_reg; //0x0000 040C
    
    always_ff @(posedge clk) begin
        uart_ctrl_reg <= {26'd0, rd_flag, 2'd0, Rxff, Fe, Ff};
        uart_rx_reg   <= {22'd0, uart_out};
    end
    always_comb begin
        brd           = uart_baud_reg [15:0];
        uart_in       = uart_tx_reg [ 7:0];
    end    

    always_ff @(posedge clk) begin
        if (write == 1) begin

            if      (mem  == 1) begin
                busy                      <= 0; //Busy
                memory[address]           <= data_in;
            end

            else if (uart == 1) begin
                case(address[3:0])
                    4'hC : begin
                        busy              <= 0; //Busy
                        uart_baud_reg     <= data_in;
                    end
                    4'h0 : begin
                        if (uart_ctrl_reg[0] == 0) begin //TxFF
                            busy          <= 1; //Busy
                            uart_tx_reg   <= data_in;
                        end
                    end
                endcase
            end

            else begin
                busy <= 0; //Busy
            end
        end

        else begin
            busy <= 0; //Busy
        end
    end

    always_comb begin
        if (read == 1) begin

            if      (mem  == 1) begin
                get               = 0; //Get Signal
                data_out          = memory[address];
            end

            else if (uart == 1) begin
                case(address[3:0])
                    4'h0 : begin
                        get       = 0; //Get Signal
                        data_out  = uart_tx_reg;
                    end
                    4'h8 : begin
                        get       = 0; //Get Signal
                        data_out  = uart_ctrl_reg;
                    end
                    4'hC : begin
                        get       = 0; //Get Signal
                        data_out  = uart_baud_reg;
                    end
                    4'h4 : begin
                        if (uart_ctrl_reg[5] == 1) begin //rd_flag
                            get      = 1; //Get Signal
                            data_out = uart_rx_reg;
                        end
                    end
                endcase
            end

            else begin
                get = 0; //Get Signal
            end
        end

        else begin
            get = 0; //Get Signal
        end
    end
endmodule