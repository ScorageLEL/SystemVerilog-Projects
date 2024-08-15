module Register_File (
    input logic clk, rst, WE3,
    input logic [4:0] A1, A2, A3,
    input logic [31:0] WD3,
    output logic RD1, RD2);

    logic [31:0] Register [31:0];

    always_ff @ (posedge clk) begin
        if (WE3 & (A3 != 5'h00)) begin
            Register[A3] <= WD3;
        end
    end

    assign RD1 = (rst == 1'b0) ? 32'd0 : Register[A1];
    assign RD2 = (rst == 1'b0) ? 32'd0 : Register[A2];

    initial begin
        Register[0] = 32'h00000000;
    end

endmodule