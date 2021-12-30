`timescale 1ns/1ps;
module testbench();
reg sensor = 0;
reg clk = 0;
reg reset = 1;
wire RA, GA, OA, RB, GB, OB;

trafficLight dut(.clk(clk), .reset(reset), .sensorB(sensor), .RA(RA), .RB(RB), .GA(GA), .GB(GB), .OA(OA), .OB(OB));

always #1 clk =~ clk;
 

initial begin
#4
reset <= 0;
#100;
sensor <= 1;
#140;
end

endmodule