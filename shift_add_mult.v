`timescale 1ps / 1ps

module shift_add_mult( CLK, ST, RST, M_PLIER, M_CAND, DONE, PRODUCT );
  parameter N = 32;

  input CLK, ST, RST;
  input [N-1 : 0] M_PLIER;
  input [N-1 : 0] M_CAND;
  output DONE;
  output [2*N-1 : 0] PRODUCT;
  
  reg [2*N-1 : 0] ACC;
  wire RST;
  wire ST, CLK;
  
  reg Q;
  
  wire [2*N-1 : 0] rca_out;
  reg add_en, shift_en;
  reg [2*N-1 : 0] ADD_OUT, PRODUCT;
  wire COUT;
  reg Cin = 1'b0;
  reg [N-1 : 0] m_shift;
  
  // set 32-bit ACC to all 0s
  initial
    begin
	   ACC = 0;
		PRODUCT = 0;
		m_shift = 0;
  end
 
 
  always @ ( posedge CLK ) begin
    if( ST == 1 ) begin
      ACC[2*N-1 : N] = 32'b00000;			// Initialize ACC with Multiplicant as lower 32 bit
	   ACC[N-1 : 0] = M_CAND;
		PRODUCT[2*N-1 : N] = 32'b0000;		// Initialize Product reg to be 0
		PRODUCT[N-1 : 0] = 32'b0000;
		m_shift[N-1 : 0] = M_PLIER;			// Move the Multipler in a temp reg for shift
		
		//START = ST;
    end
	 
	 Q = m_shift[0];								// Get the Muliplier[0] to send to FSM to select ADD or SHIFT
	 
  end
  
  //Mult_FSM is the Finite State Machine that takes in
  // Q as control signal and sends out ADD/SHIFT/DONE
  mult_fsm FSM( ST, CLK, RST, m_shift[0], ADD, SHIFT, DONE );
  
  
  //Add Initialization (RCA and CLA)
  //RCA add1( ACC, PRODUCT, Cin, rca_out, COUT );
  cla_64 CLA( .A(ACC), .B(PRODUCT), .CIN(Cin), .S(rca_out), .GG(), .PG() );
  
  
  
  //We need to check if ADD or SHIFT has changed since last CC
  // If Add = 1 then we move the output of the adder into the Product Reg
  //   from a temp reg (rca_out)
  //
  // If Shift = 1 we shift the ACC to left and m_shift to right
  always @ ( ADD or SHIFT ) begin
    if( ADD == 1 ) begin
	   PRODUCT <= rca_out;
    end else if( SHIFT == 1 ) begin
	   ACC = ACC << 1;
		m_shift = m_shift >> 1;
	 end
  end
  
  
  
endmodule

