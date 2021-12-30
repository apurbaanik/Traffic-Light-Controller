module trafficLight(input clk, reset, sensorB, output reg RA, RB, GA, GB, OA, OB);

parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
reg[1:0] state = 2'b00, next_state;
integer count;
reg timer_rst = 0;

always@(posedge clk)
begin
if(reset)
state <= S0;
else 
state <= next_state;
end

always @(posedge clk, posedge timer_rst)
begin
	if (timer_rst) begin
		count = 0;
		timer_rst = 0;
	end
	else begin
		count = count + 1;
	end
end

always@(clk,reset,sensorB, count)
	begin
case(state)
	S0:
	if(count >= 60 && sensorB == 1) begin
		next_state <= S1;
	end else
		next_state <= S0;
	S1:
	if(count >= 10)
		next_state <= S2;
	else
		next_state <= S1;
	S2:
	if(count >= 30)
		next_state <= S3;
	else
		next_state <= S2;
	S3:
	if(count >= 10)
		next_state <= S0;
	else
		next_state <= S3;
endcase
end
	
always@(state)
begin
timer_rst = 1;
{RA,OA,GA,RB,OB,GB} = 6'b000000;

case(state) 
	S0:
	begin
	GA <= 1;
	RB <= 1;
	end

	S1:
	begin
	OA <= 1;
	RB <= 1;
	end

	S2:
	begin
	GB <= 1;
	RA <= 1;
	end

	S3:
	begin
	OB <= 1;
	RA <= 1;
	end
endcase
end

endmodule