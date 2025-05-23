module DataMemory (
    input  var logic unsigned        clk,
    input  var logic unsigned        MemWrite, 
    input  var logic unsigned        MemRead,
    input  var logic unsigned [31:0] address,
    input  var logic unsigned [31:0] writeData,
    output var logic unsigned [31:0] readData,
    output var logic unsigned [31:0] datamemory36
);

    var logic [3:0][7:0] memory [511:0];

    always_comb begin
        datamemory36 = memory [36];
    end

    always_ff @(posedge clk) begin
        if (MemWrite == 1) begin
            memory[address] <= writeData;
        end
    end

    always_comb begin
        if (MemRead  == 1) begin
            readData         = memory[address];
        end
    end
endmodule
