`include "PC.v"
`include "Instr_Memory.v"
`include "Register_File.v"
//`include "Sign_Extend.v"
`include "alu32.v"
`include "top_control.v"
`include "mux2x1.v"
`include "PC_Adder4.v"
`include "Data_Memory.v"
`include "extend_block.v"
`include "mux2.v"

module top_cpu_single_core(clk,rst,PC_out,ALU_out);

input clk,rst;

output [31:0]PC_out, ALU_out;

wire [31:0]PC_top,RD_instr_top,RD1_Top,RD2_top,Imm_Ext_top,PC_Next_top,SrcB_top,PC_plus_4_top,PC_target_top,ALU_Result_top,Read_Data_top,Data_Result_top;
wire [2:0] ALU_Control_top;
wire [1:0]ImmSrc_top,ResultSrc_top;
wire RegWrite_top, Zero_top,PC_Src_top,ALU_Src_top,MemWrite_top,JAL_top;

assign PC_out = PC_top;
assign ALU_out = ALU_Result_top;

PC PC(
    .PC(PC_top),
    .PC_Next(PC_Next_top),
    .rst(rst),
    .clk(clk)
);

Instr_Memory Instr_Memory(
    .A(PC_top), 
    .RD(RD_instr_top)
);

Register_File Register_File(
    .A1(RD_instr_top[19:15]),
    .A2(RD_instr_top[24:20]),
    .A3(RD_instr_top[11:7]),
    .WE3(RegWrite_top),
    .WD3(Data_Result_top),
    .RD1(RD1_Top),
    .RD2(RD2_top),
    .clk(clk),
    .rst(rst)
);

/*Sign_Extend Sign_Extend(
    .In(RD_instr_top[31:20]),
    .Imm_Ext(Imm_Ext_top)
); */

alu32 alu32(
    .A(RD1_Top),
    .B(SrcB_top),
    .ALUcontrol(ALU_Control_top),
    .Result(ALU_Result_top),
    .Z(Zero_top),
    .N(),
    .C(),
    .V()
);

top_control top_control(
    .op(RD_instr_top[6:0]),
    .func3(RD_instr_top[14:12]),
    .func7_5th(RD_instr_top[30]),
    .Zero(Zero_top),
    .PCSrc(PC_Src_top),
    .ResultSrc(ResultSrc_top),
    .MemWrite(MemWrite_top),
    .ALUSrc(ALU_Src_top),
    .ImmSrc(ImmSrc_top),
    .RegWrite(RegWrite_top),
    .ALU_Control(ALU_Control_top),
    .JAL(JAL_top)
);

mux2x1 mux_1(
    .a(PC_plus_4_top),
    .b(PC_target_top),
    .s(PC_Src_top),
    .y(PC_Next_top)
);

mux2x1 mux_2(
    .a(RD2_top),
    .b(Imm_Ext_top),
    .s(ALU_Src_top),
    .y(SrcB_top)
);

PC_Adder4 adder_pc(
    .a(PC_top),
    .b(32'd4),
    .y(PC_plus_4_top)
);

PC_Adder4 adder_ext(
    .a(PC_top),
    .b(Imm_Ext_top),
    .y(PC_target_top)
);

Data_Memory Data_Memory(
    .clk(clk),
    .A(ALU_Result_top),
    .WD(RD2_top),
    .WE(MemWrite_top),
    .RD(Read_Data_top)
);

/*mux2x1 mux_3(
    .a(ALU_Result_top),
    .b(Read_Data_top),
    .s(ResultSrc_top),
    .y(Data_Result_top)
);*/

mux2 mux3_new(
    .p(ALU_Result_top),
    .q(Read_Data_top),
    .r(PC_plus_4_top),
    .s(ResultSrc_top),
    .y(Data_Result_top)
);



extend_block extend_block(
    .In(RD_instr_top),
    .Imm_Ext(Imm_Ext_top),
    .ImmSrc(ImmSrc_top)
);


endmodule