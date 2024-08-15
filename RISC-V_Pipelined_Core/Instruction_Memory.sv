module Instruction_Memory(
    input logic rst,
    input logic [31:0] A,
    output logic [31:0] RD);

    logic [31:0] mem [1023:0];

    assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

    initial begin
        $readmemh("memfile.hex", mem);
    end
    
endmodule