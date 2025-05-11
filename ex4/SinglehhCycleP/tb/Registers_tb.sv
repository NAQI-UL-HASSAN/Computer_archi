class baz;
    rand bit [ 4:0] a;
    rand bit [ 4:0] b;
    rand bit [ 4:0] c;
    rand bit [31:0] d;
    rand bit        e;
endclass

module Registers_tb;
	var logic unsigned [31:0] Read_data1;
 	var logic unsigned [31:0] Read_data2;
	var logic unsigned [ 4:0] Read_reg1;
	var logic unsigned [ 4:0] Read_reg2;
	var logic unsigned [ 4:0] Write_reg;
	var logic unsigned [31:0] Write_data;
	var logic unsigned 		  RegWrite;
	var logic unsigned 		  clk;
        
    Registers DUT (.*);

    task test_Registers;
        baz x;
        x            = new();
        x.randomize();
        Read_reg1    = x.a;
        Write_reg    = Read_reg1;
        Write_data   = x.d;
        RegWrite     = x.e;
    endtask

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        for (int i = 0; i < 7; i++) begin
        test_Registers();
        #20;
        $display("Read_data1 = %h, Read_data2 = %h", Read_data1, Read_data2);
        end

        Read_reg1    = 32'd0;
        Write_reg    = 32'd0;
        Write_data   = 32'd6;
        RegWrite     = 1;

    end

endmodule