`include "fetch_cycle.sv"
module fetch_cycle_tb();

    logic clk = 0, rst, PCSrcE;
    logic [31:0] PCTargetE;
    wire [31:0] InstrD, PCD, PCPlus4D;
    
    // Declare the design under test
    fetch_cycle dut (
                    .clk(clk), 
                    .rst(rst), 
                    .PCSrcE(PCSrcE),
                    .PCTargetE(PCTargetE),
                    .InstrD(InstrD), 
                    .PCD(PCD), 
                    .PCPlus4D(PCPlus4D));


    // Generation of clock
    always begin
        clk = ~clk;
        #50;
    end

    // Provide the stimulus
    initial begin
        rst <= 1'b0;
        #200
        rst <= 1'b1;
        PCSrcE <= 1'b0;
        PCTargetE <= 32'h00000000;
        #500
        $finish;



    end

    // Generation of vcd
    initial begin 
        $dumpfile("fetch_cycle_tb.vcd");
        $dumpvars(0, fetch_cycle_tb);
    end

endmodule