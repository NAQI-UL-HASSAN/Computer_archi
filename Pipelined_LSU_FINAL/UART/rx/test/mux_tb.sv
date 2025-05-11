class baz;
    rand bit a;
    rand bit b;
endclass

module mux_tb;
    logic in;
    logic sel;
    logic out;

    mux DUT(.*);

    task test_mux_comp;
        baz x;
        x            = new();
        x.randomize();

        in = x.a;
        sel = x.b;
        
    endtask


    initial begin
        for (int i = 0; i < 10; i++) begin
            test_mux_comp();
            #10;
        end
    end

endmodule