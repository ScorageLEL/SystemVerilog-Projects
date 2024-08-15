`include "Pipeline_Top.sv"

module pipeline_tb();

    reg clk = 0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end

    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        #1000;
        $finish;    
    end

    initial begin
        $dumpfile("pipeline_tb.vcd");
        $dumpvars(0, pipeline_tb);
    end

    Pipeline_top dut (.clk(clk), .rst(rst));
endmodule
