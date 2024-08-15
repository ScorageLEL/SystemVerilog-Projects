`include "Decode_Cycle.sv"

module decode_cycle_tb();

    // Declare testbench variables
    logic clk, rst, RegWriteW;
    logic [4:0] RDW;
    logic [31:0] InstrD, PCD, PCPlus4D, ResultW;
    logic RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    logic [2:0] ALUControlE;
    logic [31:0] RD1_E, RD2_E, Imm_Ext_E;
    logic [4:0] RS1_E, RS2_E, RD_E;
    logic [31:0] PCE, PCPlus4E;

    // Instantiate the decode_cycle module
    decode_cycle uut (
        .clk(clk),
        .rst(rst),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RS1_E(RS1_E),
        .RS2_E(RS2_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        RegWriteW = 0;
        RDW = 5'd0;
        InstrD = 32'h00000000;
        PCD = 32'h00000000;
        PCPlus4D = 32'h00000000;
        ResultW = 32'h00000000;

        // Apply reset
        rst = 1;
        #10;
        rst = 0;
        #10;
        rst = 1;

        // Apply test vectors
        @(posedge clk);
        InstrD = 32'h00F00793; // Example instruction
        PCD = 32'h00000004;
        PCPlus4D = 32'h00000008;
        RDW = 5'd1;
        ResultW = 32'h12345678;
        RegWriteW = 1;
        #10;
        
        @(posedge clk);
        InstrD = 32'h00A00513; // Example instruction
        PCD = 32'h00000008;
        PCPlus4D = 32'h0000000C;
        RDW = 5'd2;
        ResultW = 32'h87654321;
        RegWriteW = 0;
        #10;
        
        // Add more test vectors as needed
        // ...

        // End simulation
        #50;
        $finish;
    end

    // Monitor changes
    initial begin
        $dumpfile("decode_cycle_tb.vcd");
        $dumpvars(0, decode_cycle_tb);
        $monitor("Time=%0t clk=%b rst=%b InstrD=%h PCD=%h PCPlus4D=%h RegWriteW=%b RDW=%d ResultW=%h",
                 $time, clk, rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW);
        $monitor("RegWriteE=%b ALUSrcE=%b MemWriteE=%b ResultSrcE=%b BranchE=%b ALUControlE=%b",
                 RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE);
        $monitor("RD1_E=%h RD2_E=%h Imm_Ext_E=%h RS1_E=%d RS2_E=%d RD_E=%d PCE=%h PCPlus4E=%h",
                 RD1_E, RD2_E, Imm_Ext_E, RS1_E, RS2_E, RD_E, PCE, PCPlus4E);
    end

endmodule
