`timescale 1ns / 1ps

module testbench;

    reg clk;
    reg reset;

    riscv_simple_cpu uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, testbench);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        #200 $finish;
    end

    always #5 clk = ~clk;

endmodule
