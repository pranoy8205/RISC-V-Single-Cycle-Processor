`include "ALU_Decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(op, RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,Branch,func3,func7,ALUcontrol);

input [6:0]op,func7;
input [2:0]func3;
output RegWrite,ALUsrc,MemWrite,ResultSrc, Branch;
output [1:0]ImmSrc;
output [2:0]ALUcontrol;


wire [1:0]ALUop;

main_decoder main_decoder(
    .Zero(),
    .op(op),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUsrc),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUop),
    .PCSrc()
);

ALU_Decoder ALU_Decoder(
    func3.(func3),
    func7.(func7),
    op5.(op),
    ALUOp.(ALUop),
    ALU_Control.(ALUcontrol)
);

endmodule