module vend_tb;

reg clk;
reg rst;
reg star_pb;
reg straits_pb;

reg [1:0] in;

wire star_out;
wire straits_out;
wire green_led;
wire red_led;
wire buzzer;
wire [6:0] ssd;

vend uut(
	.clk(clk),
	.rst(rst),
	.in(in),
	.star_pb(star_pb),
	.straits_pb(straits_pb),
	.star_out(star_out),
	.straits_out(straits_out),
	.ssd(ssd),
	.green_led(green_led),
	.red_led(red_led),
	.buzzer(buzzer)	
);

initial begin
	rst = 1;
	clk = 0;
#10 star_pb = 1;
straits_pb = 0;
#20 rst = 0;
#30 in = 0;
#10 in = 1;
#10 in = 2;
#10 in = 0;
#100;
#10 straits_pb = 1;
star_pb = 0;
#10	in = 1;
#10 in = 2;
#30 in = 0;
#100;

#10 star_pb = 1;
straits_pb = 0;
#30 in = 0;
#10 in = 1;
#10 in = 1;
#10 in = 0;
#40;


#10 star_pb = 1;
straits_pb = 0;
#20 rst = 0;
#30 in = 0;
#10 in = 1;
#10 in = 2;
#10 in = 0;
#100;
#10 straits_pb = 1;
star_pb = 0;
#10	in = 1;
#10 in = 2;
#30 in = 0;
#100;

#10 star_pb = 1;
straits_pb = 0;
#30 in = 0;
#10 in = 1;
#10 in = 1;
#10 in = 0;
#40;


#10 star_pb = 1;
straits_pb = 0;
#20 rst = 0;
#30 in = 0;
#10 in = 1;
#10 in = 2;
#10 in = 0;
#100;
#10 straits_pb = 1;
star_pb = 0;
#10	in = 1;
#10 in = 2;
#30 in = 0;
#100;

#10 star_pb = 1;
straits_pb = 0;
#30 in = 0;
#10 in = 1;
#10 in = 1;
#10 in = 0;
#40;





end
always #5 clk = ~clk;
endmodule
 
