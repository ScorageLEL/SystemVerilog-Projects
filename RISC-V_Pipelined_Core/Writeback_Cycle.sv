module writeback_cycle (
    input logic clk, rst, ResultSrcW,
    input logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW,

    output logic [31:0] ResultW);

    // Module Declaration
    Mux result_mux (    
        .a(ALU_ResultW),
        .b(ReadDataW),
        .s(ResultSrcW),
        .c(ResultW));

endmodule