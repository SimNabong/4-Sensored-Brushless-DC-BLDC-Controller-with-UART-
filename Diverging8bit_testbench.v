`timescale 1ns/1ps

module Diverging8bit_testbench();
	reg [7:0] In;
	wire [11:0] CCwin;
	
	Diverging8bit Diverging8bitInst(.In(In), .CCwin(CCwin));
	
	initial begin
		In = 8'b0;
	
		#5 In = 8'b00000001; // CWM1 [0]
		#5 In = 8'b00000010; // CCW [1]
		#5 In = 8'b00000011; //R1 [0][1]
		#5 In = 8'b00000100; //R2 [2]
	
		#5 In = 8'b00000000; //all off
	
		#5 In = 8'b00001000; //M2 CW 30 [0]
		#5 In = 8'b00001001; //CCw [1]
		#5 In = 8'b00001010; //R1 [[0][1]
		#5 In = 8'b00001100; //R2 [2]
	
		#5 In = 8'b00000000;

		#5 In = 8'b00001011; //M1&M2 CW 55
		#5 In = 8'b00001110; //CCW
		#5 In = 8'b00000111; //R1
		#5 In = 8'b00001111; //R2
	
		#5 In = 8'b00000000;
	
		#5 In = 8'b00010000; //M3 CW80
		#5 In = 8'b00100000; //CCW
		#5 In = 8'b00110000; //R1
		#5 In = 8'b01000000; //R2
	
		#5 In = 8'b00000000;
	
		#5 In = 8'b10000000; // CW M4
		#5 In = 8'b11000000; // CCW
		#5 In = 8'b10100000; //R1
		#5 In = 8'b01110000; //R2
	
		#5 In = 8'b11100000; //M3&M4 CW
		#5 In = 8'b11010000; //CCW
		#5 In = 8'b10110000; //R1
		#5 In = 8'b11110000; //R2
	
		#5 In = 8'b00000000;
	
	
		#0 $finish;			
	
	end
	
	initial begin
		$monitor("simtime=%g, In=%b, CCwin=%b", $time,In,CCwin);
	end
		
		
		
endmodule