`timescale 1ps / 1ps

// `define Q0 = ACC[0];

module mult_fsm( ST, CLK, RST, Q0, ADD, SHIFT, DONE );
  parameter N = 32;
  input ST, CLK, RST, Q0;
  output ADD, SHIFT;
  output DONE;
  
  reg ADD, SHIFT, DONE;
  wire ST, CLK, RST, Q0;
  
  reg A = 64'b0001;
  reg B = 64'b0010;
  reg cout;

  parameter Idle = 3'b000,
				Test = 3'b001,
				Add = 3'b010,
				Shift = 3'b011;
				
  reg [5 : 0] curr_count = 5'b0, nxt_count = 5'b0;
				
  reg [2 : 0] curr_state = Idle; 
  wire [2 : 0] nxt_state;
  
  assign nxt_state = fsm( curr_state, ADD, SHIFT, curr_count);
  
// ---------------------------------------------------
// INITIATE 

  always @ ( posedge CLK or posedge RST )
    begin : STATE_MACHINE
	   if( RST == 1 ) begin
		  curr_state = Idle;
		  curr_count = 5'b0;
		  nxt_count = 5'b0;
		end else begin
		  curr_state = nxt_state;
		  curr_count = nxt_count;
		end
	end

// ---------------------------------------------------
// NEXT STATE LOGIC
//  Always starts at Idle State and wait for ST signal
//    IF( ST = 1 ) --> next state ==> Test;
//	   IN TEST:
//			IF( COUNT < 32 ) --> CHECK Q
//						--> IF( Q = 0 ) --> SHIFT
//						--> IF( Q = 1 ) --> ADD
//						--> ELSE STAY IN TEST
//			IF( COUNT = 32 ) --> IDLE
//
//		IN ADD: WAIT A CC and then go to SHIFT
//		IN SHIFT: UPDATE COUNT and GO to TEST

  function [2 : 0] fsm;
    input [2 : 0] curr_state;
	 input ADD, SHIFT;
	 input [5 : 0] curr_count;
	 
	 case( curr_state )
		
	   Idle : begin
  		  if( ST == 1 ) begin
		    fsm = Test;
		  end else begin
		    fsm = Idle;
		  end
		end
		Test : if( curr_count < 32 ) begin
		         if( Q0 == 1 ) begin
					  fsm = Add;
					end else if( Q0 == 0 ) begin
					  fsm = Shift;
					end else begin
					  fsm = Test;
					end
				 end else if( curr_count == 32 ) begin
				   fsm = Idle;
					DONE = 1'b1;
				 end
		Add : begin
		  fsm = Shift;
		end
		Shift : begin
		  curr_count = curr_count + 1;		// update count
		  nxt_count = curr_count;
		  fsm = Test;
		end
    endcase
  endfunction
  

// ---------------------------------------------------
// OUTPUT LOGIC 
// SETS THE OUTPUT CONTROL SIGNALS -- ADD, SHIFT, AND DONE
// IN ADD --> SETS ADD = 1;
// IN SHIFT --> SETS SHIFT = 1;
//
// OTHER STAGES EVERYTHING STAYS AT 0


  always @ ( * )
    begin : OUTPUT_LOGIC
      if( RST == 1 ) begin
		  ADD = 1'b0;
		  SHIFT = 1'b0;
		  DONE = 1'b0;
		end else begin
		
		  case( curr_state )
			 Idle : begin
				ADD = 1'b0;
				SHIFT = 1'b0;
				//DONE = 1'b0;
			 end
			 
			 Test : begin
				ADD = 1'b0;
				SHIFT = 1'b0;
				//DONE = 1'b0;
			 end
			 
			 Add : begin
			  ADD = 1'b1;
			  SHIFT = 1'b0;
			  DONE = 1'b0;
			 end
			 
			 Shift : begin
				ADD = 1'b0;
				SHIFT = 1'b1;
				DONE = 1'b0;
			 end
			 
			 default : begin
				ADD = 1'b0;
				SHIFT = 1'b0;
				DONE = 1'b0;
			 end
		  endcase
     end   
	end


endmodule
