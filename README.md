# 4-Sensored-Brushless-DC(SBLDC)-Controller-with-UART Using Verilog
This repository contains codes for a controller that allows the user to control 4 BLDC motors at the same time, using an 8-bit UART with parity checking and baud control. For more details about the UART code, check my UART repository.
The Top Entity module is the SBLDCMC_w_UART.v which contains 7 modules: the UARTReceiver, EightBit_to_SBLDCCommutation.v, BaudControl.v, UARTReceiverStateMachine.v, Eight_Bit_Parity_Checker.v, Diverging8bit.v and CommutationControl.v module.
The purpose of this module is to connect the entity modules EightBit_to_SBLDCCommutation.v and UARTReceiver.v

Currently, this controller only uses 24 out of the 256 possible combinations from the 8-bits given by the UART. Which means, this controller can be further modified/improved.
The 4 SBLDC motor has 4 functions each, which can be found in the CommutationControl.v moodule. These functions are clockwise spin,counter-clockwise spin, regenerative breaking using high-side mosfets, and regen breaking using the low-side mosfets(or any other power transistor).

To control the CommutationControl.v module, i employed an 8 to 12 diverging combinational circuit and placed it in the Diverging8bit.v module. This module allows me to use the 8-bit given by the UART to control each of the modules separately and in combinations with each other. Currently this only uses 24 combinations out of the 256 possible ones, but this is only due to the incompleteness of this system. In the near future, im planning on adding more of the functions I have designed that the motor will be able to do. Also, utilize more possible combinations and maybe use a UART that collects more that 8-bits to allow for more possible combinations. 

Here are the cuurrent Control Signals you can use for this controller:
Control signals	

CW=clockwise spin,CCW=counter-clockwise spin, R1=regenarative breaking using high-side of the mosfets, and R2=regenerative breaking using the low-side mosfets.
		
		8'b00000000; //all off
	
		4 functions of the motor 1 sbldc motor
		8'b00000001; // CW
		8'b00000010; // CCW
		8'b00000011; //R1
		8'b00000100; //R2
		
		
		4 functions of the motor 2 sbldc motor
		8'b00001000; //M2 CW 30
		8'b00001001; //CCw
		8'b00001010; //R1
		8'b00001100; //R2
	
		
		4 functions for motor 1 and motor 2  at the same time 
		8'b00001011; //M1&M2 CW 55
		8'b00001110; //CCW
		8'b00000111; //R1
		8'b00001111; //R2
	
		4 functions of the motor 3 sbldc motor
		8'b00010000; //CW 80
		8'b00100000; //CCW
		8'b00110000; //R1
		8'b01000000; //R2
	
		functions for motor 4 motor
		8'b10000000; // CW
		8'b11000000; // CCW
		8'b10100000; //R1
		8'b01110000; //R2
		
		functions for motor 3 and motor 4
		8'b11100000; //CW
		8'b11010000; //CCW
		8'b10110000; //R1
		8'b11110000; //R2
