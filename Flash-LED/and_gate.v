module and_gate
(
    i_input_a,   // AND input a
    i_input_b,   // AND input b 
    o_and_output // AND output 
);

// Defining inputs and outputs 
input i_input_a;
input i_input_b;
output o_and_output;

// Defining output for AND gate
wire and_temp;
assign and_temp = i_input_a & i_input_b;

assign o_and_output = and_temp;

endmodule 