module Instr_Memory(A, RD);

input [31:0]A;

output [31:0]RD;


// creation of memory
reg [31:0] Mem [1023:0];

assign RD = Mem[A[31:2]];

initial begin
    $readmemh("program.mem", Mem);
    $display("Mem[0] = %h", Mem[0]);
end

/*initial
 begin

Mem[0]= 32'hFFC4A303;

end*/

endmodule