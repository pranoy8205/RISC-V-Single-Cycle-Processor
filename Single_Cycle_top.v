`include "PC.v"
`include "Instr_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "alu32.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder4.v"
module Single_Cycle_top(clk,rst);

input rst,clk;

wire [31:0]PC_Top; //used to connect PC with the input A of Instruction memory
wire [31:0]RD_Instr,RD1_Top,Imm_Ext_Top,ALU_Result,Read_Data,PC_Plus4;
wire [2:0] ALU_control;
wire RegWrite;
PC PC(
    .clk(clk),
    .rst(rst),
    .PC(PC_Top),
    .PC_Next(PC_Plus4)
);

Instr_Memory Instr_Memory(
    .rst(rst),
    .A(PC_Top),
    .RD(RD_Instr)
);

Register_File Register_File(
    .A1(RD[19:15]),
    .A2(),
    .A3(RD[11:7]),
    .WE3(RegWrite),
    .WD3(Read_Data),
    .RD1(RD1_Top),
    .RD2(),
    .clk(clk),
    .rst(rst)
);

Sign_Extend Sign_Extend(
    .In(RD_Instr),
    .Imm_Ext(Imm_Ext_Top)
);

alu32 alu32(
    .A(RD1_Top),
    .B(Imm_Ext_Top),
    .ALUcontrol(ALU_control),
    .Result(ALU_Result),
    .Z(),
    .N(),
    .C(),
    .V()
);

Control_Unit_Top Control_Unit_Top(
     .op(),
     .RegWrite(RegWrite),
     .ImmSrc(),
     .ALUsrc(),
     .MemWrite(),
     .ResultSrc(),
     .Branch(),
     .func3(),
     .func7(),
     .ALUcontrol(ALU_control)
);

Data_Memory Data_Memory(
    .clk(),
    .A(ALU_Result),
    .WD(),
    .WE(),
    .RD(Read_Data)
);


PC_Adder4 PC_Adder4(
    .a(PC_Top),
    .b(32'd4),
    .c(PC_Plus4)
);

endmodule