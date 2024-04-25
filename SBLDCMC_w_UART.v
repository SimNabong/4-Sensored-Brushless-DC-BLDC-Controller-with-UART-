module SBLDCMC_w_UART(
	input Rx_in, //Receiver Input from Transmitter
	input clk, //external 50Mhz clk
	input reset, //User reset input
	input [2:0]BC, //user baud rate control selection (~B3&~B2&B1)?9'd217:(~B3&B2&~B1)?9'd109:(~B3&B2&B1)?9'd72:(B3&~B2&~B1)?9'd36:9'd434;
	input [2:0]HS1,HS2,HS3,HS4, //3 HALL SENSOR SIGNALS FROM each MOTOR
	output Mreset, //sends a reset signal to the transmitter
	output [7:0]DataOut,
	output [23:0]PT
);
	
	
	wire [7:0]DataOutw;
	
	wire Rx_clkw;
	
	reg [7:0]DataOutr,DataOutr1;
	
	assign DataOut = DataOutw;
	
	UARTReceiver UARTReceiverInst(.Rx_in(Rx_in), .clk(clk), .reset(reset), .BC(BC), .DataOut(DataOutw), .Mreset(Mreset), .Rx_clkw(Rx_clkw));
	
	always@(posedge clk) begin
		DataOutr1 <= DataOutw;
		DataOutr <= DataOutr1;
	end

	EightBit_to_SBLDCCommutation EightBit_to_SBLDCCommutationInst(.In(DataOutr), .clk(Rx_clkw), .HS1(HS1), .HS2(HS2), . HS3(HS3), .HS4(HS4), .PT(PT));



endmodule