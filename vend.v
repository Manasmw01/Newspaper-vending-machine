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
	star_out = 0;
	straits_out = 0;
	out = 0;
	flag = 0;
	ssd = 7'b0000000;
	green_led = 0;
	buzzer = 0;
	red_led = 0;
	end
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
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
	$display("Insert the money");
	flag = 1;
#5 ssd = 7'b1111011 ;
#5 ssd = 7'b1111111;
#5 ssd = 7'b1110000;
#5 ssd =7'b1011111 ;
#5 ssd = 7'b1011011 ;
#5 ssd =7'b0110011 ;
#5 ssd =7'b1111001 ;
#5 ssd = 7'b1101101 ;
#5 ssd =  7'b0110000;
#5 ssd = 7'b1111110;
#5 ssd = 7'b0000000;
$display("Thank you");	

	straits_out = 0;
	#5 star_out = 1;
	#5 star_out = 0;
	end
	else if(straits_pb ==1)
	begin
	$display("Insert the money");	
	flag = 1;
#5 ssd = 7'b1111011 ;
#5 ssd = 7'b1111111;
#5 ssd = 7'b1110000;
#5 ssd =7'b1011111 ;
#5 ssd = 7'b1011011 ;
#5 ssd =7'b0110011 ;
#5 ssd =7'b1111001 ;
#5 ssd = 7'b1101101 ;
#5 ssd =  7'b0110000;
#5 ssd = 7'b1111110;
#5 ssd = 7'b0000000;
$display("Thank you");	

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
		n_state = S0;
		out = 0;
		end
		else if (in == 2'b01)
		begin
		n_state = S1;
		out = 0;
		end
		else if (in == 2'b10)
		begin
		n_state = S2;
		out = 0;
		end
		
		
	S1: if (in == 0)                    // S1 is 0.5Rs State
		begin
		n_state = S0;
		out = 0;
		#10 red_led = 1;
		#5 red_led = 0;
		end
		else if (in == 2'b01)
		begin
		n_state = S2;
		out = 0;
		end
		else if (in == 2'b10)
		begin
		n_state = S0;
		
		#10 out = 1;
		green_led = 1;
		buzzer = 1;

		#5 out = 0;
		green_led = 0;
		buzzer = 0;

		end
		
		
	S2: if (in == 0)                   // S2 is 1 Rs State
		begin
		n_state = S0;
		out = 0;
		#10 red_led = 1;
		#5 red_led = 0;
		end
		else if (in == 2'b01)
		begin
		n_state = S0;
		#10 out = 1;
		green_led = 1;
		buzzer = 1;

		#5 out = 0;
		green_led = 0;
		buzzer = 0;

		end
		else if (in == 2'b10)
		begin
		n_state = S0;
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

		
		
		
		
		