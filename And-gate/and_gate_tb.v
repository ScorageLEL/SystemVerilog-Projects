`timescale 1ns/1ns
`include "and_gate.v"

module and_gate_tb;

reg i_input_a;
reg i_input_b;
wire o_and_output;

and_gate uut(i_input_a, i_input_b, o_and_output);

initial begin
    $dumpfile("and_gate_tb.vcd");
    $dumpvars(0, and_gate_tb);

    i_input_a = 0;
    i_input_b = 0;
    #10;

    i_input_a = 0;
    i_input_b = 1;
    #10;

    i_input_a = 1;
    i_input_b = 0;
    #10;

    i_input_a = 1;
    i_input_b = 1;
    #30;

    i_input_a = 0;
    i_input_b = 0;
    #10;

    i_input_a = 1;
    i_input_b = 1;
    #10;

    i_input_a = 1;
    i_input_b = 0;
    #10;

    $display("Test complete");

end
sdsd

endmodule