module ALU_Decoder(func3, func7_5th, op5th, ALUOp, ALU_Control);

input op5th, func7_5th;
input [2:0]func3;
input [1:0]ALUOp;
output [2:0]ALU_Control;


wire[1:0]concatenate;

assign concatenate= {op5th, func7_5th};

assign ALU_Control= (ALUOp==2'b00)? 3'b000: //  lw , sw
                    (ALUOp==2'b01)? 3'b001:  // beq
                    ((ALUOp==2'b10) && (func3==3'b010))? 3'b101:  // slt
                    ((ALUOp==2'b10) && (func3==3'b110))? 3'b011: // or     
                    ((ALUOp==2'b10) && (func3==3'b111))? 3'b010:  // and
                    ((ALUOp==2'b10) && (func3==3'b000) && (concatenate==2'b11))? 3'b001: // sub
                    ((ALUOp==2'b10) && (func3==3'b000) && (concatenate!=2'b11))? 3'b000 : 3'b000; // add

endmodule