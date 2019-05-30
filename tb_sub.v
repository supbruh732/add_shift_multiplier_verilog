`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:45:18 05/10/2019
// Design Name:   sub_16
// Module Name:   C:/Users/Home PC/OneDrive/Documents/Spring 2019/ECE 465/Xlinix Project/MULT/tb_sub.v
// Project Name:  MULT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sub_16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_sub;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg BIN;

	// Outputs
	wire [15:0] D;
	wire BOUT;

	// Instantiate the Unit Under Test (UUT)
	sub_16 uut (
		.A(A), 
		.B(B), 
		.BIN(BIN), 
		.D(D), 
		.BOUT(BOUT)
	);

	initial begin
		// Initialize Inputs
		A = 4;
		B = 2;
		BIN = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		
		A = 64;
		B = 30;
		BIN = 0;

		// Wait 100 ns for global reset to finish
		#100;
		

		A = 12000;
		B = 11999;
		BIN = 0;

		// Wait 100 ns for global reset to finish
		#100;


		A = 35000;
		B = 12459;
		BIN = 0;

		// Wait 100 ns for global reset to finish
		#100;


		A = 65355;
		B = 35000;
		BIN = 0;

		// Wait 100 ns for global reset to finish
		#100;			
        
		// Add stimulus here

	end
      
endmodule

