`include "ALU_Decoder.v"
`include "main_decoder.v"

module top_control(op,func3,func7_5th,Zero,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,ALU_Control,JAL);

input[6:0]op;
input[2:0]func3;
input func7_5th,Zero;

output [2:0]ALU_Control;
output [1:0]ImmSrc,ResultSrc;
output PCSrc,MemWrite,ALUSrc,RegWrite,JAL;

// wire declaration

wire [1:0] ALUOp;

ALU_Decoder ALU_Decoder(
    .func3(func3),
    .func7_5th(func7_5th),
    .op5th(op[5]), 
    .ALUOp(ALUOp), 
    .ALU_Control(ALU_Control)
);

main_decoder main_decoder(
    .Zero(Zero),
    .op(op),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc), 
    .ALUSrc(ALUSrc), 
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp), 
    .PCSrc(PCSrc),
    .JAL(JAL)
);

endmodule