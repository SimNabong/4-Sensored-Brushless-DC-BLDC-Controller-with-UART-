//all 4 motors can individually be control to either spin CW, spin CCW, and regen break 2. for regen break 1, they break together in 2's. motor 1 and 2 together and 3 and 4 together. 
//the 4 functions each motor has is clockwise spin,counter-clockwise spin, regenerative breaking using high-side mosfets, and regen breaking using the low-side mosfets
//this is a diverging combinationalcircuit that goes from 8(the 8-bits from the UART receiver) to 12(the input for the commutation controller for the motor)
module Diverging8bit(
	input [7:0] In, //8-bit input from the receiver
	input clk,
	output [11:0]CCin //commutationcontroller input 0to2 is M1,3-5 is m2,6-8 is m3,9-11 is m4
//these outputs are fed into the motor commutatiom controller, each motor having individual commutiontion controller with 3 input each
);

	reg [1:0] CCinr25 = 2'd0;
	reg [1:0] CCinr811 = 2'd0;
	
	always@(posedge clk) begin //extra delay for the power trans safety
		CCinr25[0] <= In[0]&In[1]&In[2]&In[3];
		CCinr25[1] <= CCinr25[0];
		CCinr811[0] <= In[4]&In[5]&In[6]&In[7];
		CCinr811[1] <= CCinr811[0];
	end
																														// if CCW and CW are on then it's also regen break 2
	assign CCin[2] = In[0]&(~In[1]|~In[2]|~In[3]|~In[4]|~In[5]|~In[6]|~In[7])&~CCinr25[1]; //motor 1 CCW spin
	assign CCin[1] = In[1]&(~In[0]|~In[2]|~In[3]|~In[4]|~In[5]|~In[6]|~In[7])&~CCinr25[1];	//motor 1 CW spin
	assign CCin[0] = CCinr25[1];																				//regen break 1 for motor 1 and motor 2
	
	
	assign CCin[5] = In[2]&(~In[0]|~In[1]|~In[3]|~In[4]|~In[5]|~In[6]|~In[7])&~CCinr25[1]; //Motor 2
	assign CCin[4] = In[3]&(~In[0]|~In[1]|~In[2]|~In[4]|~In[5]|~In[6]|~In[7])&~CCinr25[1];
	assign CCin[3] = CCinr25[1];																				//regen break for motor 3 and 4
	
	assign CCin[8] = In[4]&(~In[0]|~In[1]|~In[2]|~In[3]|~In[5]|~In[6]|~In[7])&~CCinr811[1]; //Motor 3
	assign CCin[7] = In[5]&(~In[0]|~In[1]|~In[2]|~In[3]|~In[4]|~In[6]|~In[7])&~CCinr811[1];
	assign CCin[6] = CCinr811[1];
	
	assign CCin[11] = In[6]&(~In[0]|~In[1]|~In[2]|~In[3]|~In[4]|~In[5]|~In[7])&~CCinr811[1]; //Motor 4
	assign CCin[10] = In[7]&(~In[0]|~In[1]|~In[2]|~In[3]|~In[4]|~In[5]|~In[6])&~CCinr811[1];
	assign CCin[9] = CCinr811[1];
	
	


endmodule
