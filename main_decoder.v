module main_decoder(
    Zero, op,
    RegWrite, MemWrite, ResultSrc,
    ALUSrc, ImmSrc, ALUOp, PCSrc,JAL
);

// inputs
input Zero;
input [6:0] op;

// outputs
output reg RegWrite, MemWrite, ALUSrc, PCSrc,JAL;
output reg [1:0] ImmSrc, ALUOp, ResultSrc;

// internal
reg branch;

always @(*) begin
    // 🔥 DEFAULT VALUES (VERY IMPORTANT)
    RegWrite = 0;
    MemWrite = 0;
    ResultSrc = 2'b00;
    ALUSrc   = 0;
    ImmSrc   = 2'b00;
    ALUOp    = 2'b00;
    branch   = 0;
    JAL = 0;

    case(op)

        // 🔹 LOAD (LW)
        7'b0000011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ResultSrc= 2'b01;
            ImmSrc   = 2'b00;
            ALUOp    = 2'b00;
            ResultSrc = 2'b01;
        end

        // 🔹 STORE (SW)
        7'b0100011: begin
            MemWrite = 1;
            ALUSrc   = 1;
            ImmSrc   = 2'b01;
            ALUOp    = 2'b00;
        end

        // 🔹 R-TYPE (ADD, SUB, etc.)
        7'b0110011: begin
            RegWrite = 1;
            ALUOp    = 2'b10;
            ResultSrc = 2'b00;
        end

        // 🔹 I-TYPE (ADDI)
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
            ResultSrc = 2'b00;
        end

        // 🔹 BRANCH (BEQ)
        7'b1100011: begin
            branch = 1;
            ImmSrc = 2'b10;
            ALUOp  = 2'b01;
        end

        // JAL
        7'b1101111: begin
            RegWrite = 1;
            ResultSrc = 2'b10;
            ImmSrc = 2'b11;
            JAL = 1;


        end
        default: begin
            // keep defaults
        end


    endcase

    // PC control
    PCSrc = (Zero & branch) | JAL;

end

endmodule