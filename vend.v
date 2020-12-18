module vend(
	input clk,
	input rst,
	input [1:0] in,
	input star_pb,
	input straits_pb,
	output reg star_out,
	output reg straits_out,
	output reg green_led,
	output reg red_led,
	output reg buzzer,
	output reg [6:0] ssd
	);
reg out;
reg flag;

initial 
	begin
	star_out = 0;					// resetting all variables
	straits_out = 0;
	out = 0;
	flag = 0;
	ssd = 7'b0000000;
	green_led = 0;
	buzzer = 0;
	red_led = 0;
	end
parameter S0 = 2'b00;				// Reset State
parameter S1 = 2'b01;				// 0.5 Rs State
parameter S2 = 2'b10;				// 1 Rs State		
integer i;
reg[1:0] c_state,n_state;

always @(posedge out)
if (rst == 1)
	begin
	ssd = 7'b0000000;
	straits_out = 0;
	star_out = 0;	
	end
else 
begin
	if(star_pb ==1)
	begin
	$display("Star pressed");		
	flag = 1;
#5 ssd = 7'b1111011 ;				// Seven Segment Display value to print digit 9
	$display("--9--");
#5 ssd = 7'b1111111;				// Seven Segment Display value to print digit 8
	$display("--8--");
#5 ssd = 7'b1110000;				// Seven Segment Display value to print digit 7
	$display("--7--");
#5 ssd =7'b1011111 ;				// Seven Segment Display value to print digit 6
	$display("--6--");
#5 ssd = 7'b1011011 ;				// Seven Segment Display value to print digit 5
	$display("--5--");
#5 ssd =7'b0110011 ;				// Seven Segment Display value to print digit 4
	$display("--4--");
#5 ssd =7'b1111001 ;				// Seven Segment Display value to print digit 3
	$display("--3--");
#5 ssd = 7'b1101101 ;				// Seven Segment Display value to print digit 2
	$display("--2--");
#5 ssd =  7'b0110000;				// Seven Segment Display value to print digit 1
	$display("--1--");
#5 ssd = 7'b1111110;				// Seven Segment Display value to print digit 0
	$display("--0--");
#5 ssd = 7'b0000000;
$display("Here's your Star Times");
$display("Thank you \n \n");	

	straits_out = 0;
	#5 star_out = 1;
	#5 star_out = 0;
	end
	else if(straits_pb ==1)
	begin
	$display("Straits pressed");
	flag = 1;
#5 ssd = 7'b1111011 ;				// Seven Segment Display value to print digit 9
	$display("--9--");
#5 ssd = 7'b1111111;				// Seven Segment Display value to print digit 8
	$display("--8--");
#5 ssd = 7'b1110000;				// Seven Segment Display value to print digit 7
	$display("--7--");
#5 ssd =7'b1011111 ;				// Seven Segment Display value to print digit 6
	$display("--6--");
#5 ssd = 7'b1011011 ;				// Seven Segment Display value to print digit 5
	$display("--5--");
#5 ssd =7'b0110011 ;				// Seven Segment Display value to print digit 4
	$display("--4--");
#5 ssd =7'b1111001 ;				// Seven Segment Display value to print digit 3
	$display("--3--");
#5 ssd = 7'b1101101 ;				// Seven Segment Display value to print digit 2
	$display("--2--");
#5 ssd =  7'b0110000;				// Seven Segment Display value to print digit 1
	$display("--1--");
#5 ssd = 7'b1111110;				// Seven Segment Display value to print digit 0
	$display("--0--");
#5 ssd = 7'b0000000;

$display("Here's your Straits Times");
$display("Thank you \n  \n");	

	#5 straits_out = 1;
	#5 straits_out = 0;
	star_out = 0;
	end
	flag = 0;
	end

always @(posedge clk)
begin
if (rst == 1)
	begin
	c_state = 0;
	n_state = 0;
	end

else if((star_pb || straits_pb )&& ~flag)
	begin 
	c_state = n_state;
	case(c_state)
	S0: if (in == 0)                    // S0 is Reset State
		begin
		$display("Insert the money");
		n_state = S0;					// Stay in Reset state
		out = 0;
		end
		else if (in == 2'b01)
		begin
		n_state = S1;					// 0.5 Rs entered -> Go to state S1 : 0.5Rs state
		out = 0;
		end
		else if (in == 2'b10)
		begin
		n_state = S2;					// 1 Rs entered -> Go to state S1 : 1 Rs state
		out = 0;
		end
		
		
	S1: if (in == 0)                    // S1 is 0.5Rs State
		begin
		n_state = S0;					// 0 Rs entered after 0.5 Rs -> Incomplete amount -> Go to state S0 : Reset state
		out = 0;
		#10 red_led = 1;
		#5 red_led = 0;
		$display("Wrong Amount entered \n");
		$display("Please try again \n");
		end
		else if (in == 2'b01)
		begin
		n_state = S2;					// 0.5 Rs entered after 0.5 Rs -> Go to state S2 : 1 Rs state
		out = 0;
		end
		else if (in == 2'b10)
		begin
		n_state = S0;					// 1 Rs entered after 0.5 Rs -> Correct amount -> Set output and Go to state S0 : Reset state
		
		#10 out = 1;
		green_led = 1;
		buzzer = 1;

		#5 out = 0;
		green_led = 0;
		buzzer = 0;

		end
		
		
	S2: if (in == 0)                   // S2 is 1 Rs State
		begin
		n_state = S0;					// 0 Rs entered after 10Rs -> Incomplete amount -> Go to reset state 
		out = 0;
		$display("Wrong Amount entered");
		$display("Please try again \n");
		#10 red_led = 1;
		#5 red_led = 0;
		end
		else if (in == 2'b01)
		begin
		n_state = S0;					// 0.5 Rs entered after 10Rs -> Correct amount -> Set output and Go to state S0 : Reset state
		#10 out = 1;
		green_led = 1;
		buzzer = 1;

		#5 out = 0;
		green_led = 0;
		buzzer = 0;

		end
		else if (in == 2'b10)
		begin
		n_state = S0;					// 10Rs entered after 10Rs -> Correct amount -> Go to state S0: Reset state
		#10 out = 1;
		green_led = 1;
		buzzer = 1;

		#5 out = 0;
		green_led = 0;
		buzzer = 0;

		end
		
	endcase
end	
end
endmodule

		
		
		
		
		
