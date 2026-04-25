module alu32(A,B,ALUcontrol,Result,Z,N,C,V);

//Delaring inputs 
input [31:0]A,B;
input [2:0]ALUcontrol;

//Declaring output
output [31:0]Result;

//Flags 
output Z,N,C,V;

// Declaring wires

wire [31:0]a_and_b;
wire [31:0]a_or_b;
wire [31:0]not_b;

wire [31:0]mux_1;
wire [31:0]sum;
wire [31:0]mux_2;

wire cout;

wire [31:0]slt;

// Logic AND 

assign a_and_b = A & B;

// Logic OR 

assign  a_or_b = A | B;

// NOT operation on B

assign not_b= ~B;

//Ternary operator 

assign mux_1= (ALUcontrol[0]== 1'b0)? B: not_b;

// Addition or Subtraction operation 
assign {cout,sum} = A+mux_1+ ALUcontrol[0];

//Zero Extension

assign slt={31'b0,sum[31]};

//Designing 4 byte mux

assign mux_2= (ALUcontrol[2:0]==3'b000)? sum : (ALUcontrol[2:0]==3'b001)? sum : (ALUcontrol[2:0]==3'b010)? a_and_b :(ALUcontrol[2:0]==3'b011)? a_or_b: (ALUcontrol[2:0]==3'b101)? slt : 32'b0;


assign Result=mux_2;


//Flags Design

assign Z= &(~Result); // Zero flag

assign N= Result[31]; // Negative flag

assign C= cout & ~(ALUcontrol[1]);  // Carry flag

assign V= ~(ALUcontrol[1]) & (A[31] ^ sum[31]) & (~(ALUcontrol[0] ^ A[31] ^ B[31])); // Overflow flag
endmodule