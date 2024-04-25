//currently only uses 24 out of the 256 possible combinations that the 4 motors with 4 functions each can do.
//the 4 functions each motor has is clockwise spin,counter-clockwise spin, regenerative breaking using high-side mosfets, and regen breaking using the low-side mosfets
//this is an 8 to 12 diverging combinational circuit
module Diverging8bit(
	input [7:0] In, //8-bit input from the receiver
	output [11:0]CCin //commutationcontroller input 0to2 is M1,3-5 is m2,6-8 is m3,9-11 is m4
//these outputs are fed into the motor commutatiom controller, each motor having individual commutiontion controller with 3 input each
);

	/* N = 0 to 2,
		MotorN[0] is for clockwise spin
		MotorN[1] is for counter-clockwise spin
		MotorN[2] is for 1 of the regen break
		both MotorN[0] and MotorN[1] at the same time is also regn break
	*/
	
	assign CCin[2] = In[0]&~In[2]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[0]&In[1]&~In[2]&~In[4]&~In[5]&~In[6]&~In[7] | In[0]&In[1]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7];
	assign CCin[1] = In[0]&In[1]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[1]&~In[2]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | ~In[0]&In[1]&In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7];
	assign CCin[0] = ~In[0]&~In[1]&In[2]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[0]&In[1]&In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7];
	
	assign CCin[5] = In[0]&In[1]&In[2]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | ~In[0]&~In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[1]&~In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7];
	assign CCin[4] = In[0]&In[1]&In[2]&~In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[0]&~In[1]&~In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7] | ~In[0]&In[1]&In[3]&~In[4]&~In[5]&~In[6]&~In[7];
	assign CCin[3] = ~In[0]&~In[1]&In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7] | In[0]&In[1]&In[2]&In[3]&~In[4]&~In[5]&~In[6]&~In[7];

	assign CCin[8] = ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&~In[6]&~In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&In[5]&~In[6] | ~In[0]&~In[1]&~In[2]&~In[3]&~In[4]&In[5]&In[6]&In[7];
	assign CCin[7] = ~In[0]&~In[1]&~In[2]&~In[3]&In[5]&~In[6]&~In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&In[5]&~In[6] | ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&~In[5]&In[6]&In[7];
	assign CCin[6] = ~In[0]&~In[1]&~In[2]&~In[3]&~In[4]&~In[5]&In[6]&~In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&In[5]&In[6]&In[7];
	
	assign CCin[11] = ~In[0]&~In[1]&~In[2]&~In[3]&~In[4]&~In[6]&In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&In[5]&~In[6]&In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&~In[4]&In[5]&In[7];
	assign CCin[10] = ~In[0]&~In[1]&~In[2]&~In[3]&In[5]&~In[6]&In[7] | ~In[0]&~In[1]&~In[2]&~In[3]&~In[5]&In[6]&In[7];
	assign CCin[9] = ~In[0]&~In[1]&~In[2]&~In[3]&In[4]&In[5]&In[6];



endmodule
