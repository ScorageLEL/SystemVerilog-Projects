`timescale 1ns/1ps
`include "Execute_Cycle.sv"

module Execute_Cycle_tb();

    // Testbench Signals
    logic clk, rst;
    logic RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    logic [2:0] ALUControlE;
    logic [31:0] RD1_E, RD2_E, Imm_Ext_E;
    logic [4:0] RD_E;
    logic [31:0] PCE, PCPlus4E;
    logic [31:0] ResultW;
    logic [1:0] ForwardA_E, ForwardB_E;

    logic PCSrcE, RegWriteM, MemWriteM, ResultSrcM;
    logic [4:0] RD_M;
    logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    logic [31:0] PCTargetE;

    // Instantiate the DUT (Device Under Test)
    Execute_Cycle dut (
        .clk(clk), 
        .rst(rst), 
        .RegWriteE(RegWriteE), 
        .ALUSrcE(ALUSrcE), 
        .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE), 
        .BranchE(BranchE),
        .ALUControlE(ALUControlE), 
        .RD1_E(RD1_E), 
        .RD2_E(RD2_E), 
        .Imm_Ext_E(Imm_Ext_E), 
        .RD_E(RD_E), 
        .PCE(PCE), 
        .PCPlus4E(PCPlus4E),
        .ResultW(ResultW), 
        .ForwardA_E(ForwardA_E), 
        .ForwardB_E(ForwardB_E),
        .PCSrcE(PCSrcE), 
        .RegWriteM(RegWriteM), 
        .MemWriteM(MemWriteM), 
        .ResultSrcM(ResultSrcM), 
        .RD_M(RD_M), 
        .PCPlus4M(PCPlus4M), 
        .WriteDataM(WriteDataM), 
        .ALU_ResultM(ALU_ResultM),
        .PCTargetE(PCTargetE)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test Vectors
    initial begin
        // Initialize all inputs
        rst = 0;
        RegWriteE = 0;
        ALUSrcE = 0;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b000;
        RD1_E = 32'h00000000;
        RD2_E = 32'h00000000;
        Imm_Ext_E = 32'h00000000;
        RD_E = 5'h00;
        PCE = 32'h00000000;
        PCPlus4E = 32'h00000000;
        ResultW = 32'h00000000;
        ForwardA_E = 2'b00;
        ForwardB_E = 2'b00;

        // Apply reset
        #10 rst = 1;
        #10 rst = 0;

        // Test case 1: Simple addition
        RegWriteE = 1;
        ALUSrcE = 1;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b000; // ADD operation
        RD1_E = 32'h00000005;
        RD2_E = 32'h00000003;
        Imm_Ext_E = 32'h00000010;
        RD_E = 5'h01;
        PCE = 32'h00000020;
        PCPlus4E = 32'h00000024;
        ResultW = 32'h00000008;
        ForwardA_E = 2'b01; // Forward ResultW to Src_A
        ForwardB_E = 2'b00; // No forwarding to Src_B
        #10;

        // Test case 2: Simple subtraction
        RegWriteE = 1;
        ALUSrcE = 1;
        MemWriteE = 0;
        ResultSrcE = 0;
        BranchE = 0;
        ALUControlE = 3'b001; // SUB operation
        RD1_E = 32'h00000005;
        RD2_E = 32'h00000003;
        Imm_Ext_E = 32'h00000010;
        RD_E = 5'h02;
        PCE = 32'h00000030;
        PCPlus4E = 32'h00000034;
        ResultW = 32'h00000008;
        ForwardA_E = 2'b10; // Forward ALU_ResultM to Src_A
        ForwardB_E = 2'b00; // No forwarding to Src_B
        #10;

        // Add more test cases as needed...

        // Finish simulation
        #100;
        $finish;
    end

    // Monitor signals
    initial begin
        $dumpfile("execute_cycle_tb.vcd");
        $dumpvars(0, Execute_Cycle_tb);
        $monitor("Time=%0t, clk=%b, rst=%b, RegWriteE=%b, ALUSrcE=%b, MemWriteE=%b, ResultSrcE=%b, BranchE=%b, ALUControlE=%b, RD1_E=%h, RD2_E=%h, Imm_Ext_E=%h, RD_E=%h, PCE=%h, PCPlus4E=%h, ResultW=%h, ForwardA_E=%b, ForwardB_E=%b, PCSrcE=%b, RegWriteM=%b, MemWriteM=%b, ResultSrcM=%b, RD_M=%h, PCPlus4M=%h, WriteDataM=%h, ALU_ResultM=%h, PCTargetE=%h",
            $time, clk, rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, ResultW, ForwardA_E, ForwardB_E, PCSrcE, RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE);
    end

endmodule