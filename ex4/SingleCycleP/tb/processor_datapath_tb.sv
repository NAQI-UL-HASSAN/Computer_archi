module processor_datapath_tb;
    logic rst;
    logic clk;

    SingleCycleProc DUT (.*);

    task test_Processor;
        $readmemh("test.txt",DUT.memory);
        for (int i = 0; i < 10; i++) begin
            Instruction_address = i * 4;
            #10;
            $display("Address: %0d | Expected: %h | Read: %h", i, temp[i], Instruction);
        end
    endtask
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #5;
        rst = 0;
        for (int i = 0; i < 5; i++) begin
            test_processor_datapath();
            #10;
            $display("sel = %b, sel2 = %b, regw = %b, alu_src = %b, memw = %b, memr = %b, alu_op = %b, inst_control = %b, inst_alu = %b, zero_flag = %b", 
                     sel, sel2, regw, alu_src, memw, memr, alu_op, inst_control, inst_alu, zero_flag);
        end
    end
endmodule
