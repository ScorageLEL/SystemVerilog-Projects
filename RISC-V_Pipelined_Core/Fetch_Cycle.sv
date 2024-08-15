module fetch_cycle(
    // Inputs and outputs
    input logic clk, rst, PCSrcE, 
    input logic [31:0] PCTargetE,
    output logic [31:0] InstrD, PCD, PCPlus4D);

    // Declaration of internal logic
    logic [31:0] PC_F, PCF, PCPlus4F, InstrF;

    // Declaration of register
    logic [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;

    // Initiating Modules

    // Declare PC Mux
    Mux PC_Mux(
        .a(PCPlus4F), 
        .b(PCTargetE), 
        .s(PCSrcE),
        .c(PC_F));

    // Declare Program Counter
    PC_Module Program_Counter(
        .clk(clk),
        .rst(rst),
        .PC_Next(PC_F),
        .PC(PCF));

    // Declare PC Adder
    PC_Adder PC_Adder(
        .a(PCF),
        .b(32'h00000004),
        .c(PCPlus4F));

    // Declare Instruction Memory
    Instruction_Memory IMEM(
        .rst(rst),
        .A(PCF),
        .RD(InstrF));

    // Fetch Cycle Register Logic
    always_ff @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end 
        
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end

    end

    // Assigning Registers Value to the Output port
    assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule
