module PC_Adder(
    input logic [31:0] a, b,
    output logic [31:0] c);

    assign c = a + b;

endmodule