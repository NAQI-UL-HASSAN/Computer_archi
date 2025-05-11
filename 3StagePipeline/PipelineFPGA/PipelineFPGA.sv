module PipelineFPGA (
    input  var logic        clk,
    input  var logic        rst,
    output var logic        an0, an1, an2, an3, an4, an5, an6, an7,
    output var logic        segA, segB, segC, segD, segE, segF, segG
);
logic [31:0] fpga;
logic clk1;
logic [2:0] count_d, count_q;

PipelineProcessor PipelineProcessor (.*);

clk_delay         tff               (
                                    .clk     (clk),
                                    .reset   (rst),
                                    .clk_out (clk1)
                                    );

//COUNTER
always_comb count_d = count_q + 1;
always_ff@(posedge clk1 or posedge rst)
begin
    if (rst) begin
        count_q <= 0;
    end
    else begin
        count_q <= count_d;
    end
end

//MUX1
logic [3:0] y;
always_comb begin
    case (count_q)
            3'b000: y = fpga[3:0];
            3'b001: y = fpga[7:4];
            3'b010: y = fpga[11:8];
            3'b011: y = fpga[15:12];
            3'b100: y = fpga[19:16];
            3'b101: y = fpga[23:20];
            3'b110: y = fpga[27:24];
            3'b111: y = fpga[31:28];
    endcase
end

//DECODER FOR CATHODE
logic [6:0] sara;
always_comb
begin
                 segA = sara[6];
                 segB = sara[5];
                 segC = sara[4];
                 segD = sara[3];
                 segE = sara[2];
                 segF = sara[1];
                 segG = sara[0];
end

always_comb begin
    case (y)
        4'b0000: sara = 7'b0000001;
        4'b0001: sara = 7'b1001111;
        4'b0010: sara = 7'b0010010;
        4'b0011: sara = 7'b0000110;
        4'b0100: sara = 7'b1001100;
        4'b0101: sara = 7'b0100100;
        4'b0110: sara = 7'b0100000;
        4'b0111: sara = 7'b0001111;
        4'b1000: sara = 7'b0000000;
        4'b1001: sara = 7'b0000100;
        4'b1010: sara = 7'b0001000;
        4'b1011: sara = 7'b1100000;
        4'b1100: sara = 7'b0110001;
        4'b1101: sara = 7'b1000010;
        4'b1110: sara = 7'b0110000;
        4'b1111: sara = 7'b0111000;
    endcase
end

//DECODER FOR ANODE
logic [7:0] zulfi;
always_comb
begin
                  an0 = zulfi[7];
                  an1 = zulfi[6];
                  an2 = zulfi[5];
                  an3 = zulfi[4];
                  an4 = zulfi[3];
                  an5 = zulfi[2];
                  an6 = zulfi[1];
                  an7 = zulfi[0];
end

always_comb begin
    case (count_q)
        3'b000: zulfi = 8'b01111111;
        3'b001: zulfi = 8'b10111111;
        3'b010: zulfi = 8'b11011111;
        3'b011: zulfi = 8'b11101111;
        3'b100: zulfi = 8'b11110111;
        3'b101: zulfi = 8'b11111011;
        3'b110: zulfi = 8'b11111101;
        3'b111: zulfi = 8'b11111110;
    endcase
end
endmodule