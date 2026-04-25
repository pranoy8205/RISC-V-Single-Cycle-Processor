module Single_Cycle_top_tb();

reg clk=1'b1, rst;

top_cpu_single_core uut(
    .clk(clk),
    .rst(rst)
);

initial begin
     
$dumpfile("top_cpu_single_core.vcd");
$dumpvars(0);


end

initial clk = 0;

always #50 clk = ~clk;

initial
begin
rst = 1'b0;     // Apply reset first
#100;
rst = 1'b1;     // Release reset

#1000;
$finish;
end



endmodule