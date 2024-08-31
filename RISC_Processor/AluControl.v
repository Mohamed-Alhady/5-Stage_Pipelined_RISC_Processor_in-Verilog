module AluCtrl(

input  [1:0]   AluOp    ,
input  [3:0]   AluFun   ,
	   
output reg [2:0]   CTRL_OP

);


always @(*)
	begin
		case({AluOp,AluFun} )
		
		6'b00xxxx :
			CTRL_OP <= 3'b000 ;
			
		6'b01xxxx :
			CTRL_OP <= 3'b001 ;
		
		6'b100010 :
			CTRL_OP <= 3'b000 ;
		
		6'b100110 :		
			CTRL_OP <= 3'b001 ;			
		
		6'b100000 :		
			CTRL_OP <= 3'b010 ;	
		
		6'b100001 :		
			CTRL_OP <= 3'b011 ;	
		
		6'b100001 :		
			CTRL_OP <= 3'b011 ;
		
		6'b100111 :		
			CTRL_OP <= 3'b011 ;
		
		default   : 
			CTRL_OP <= 3'b000;
			
		endcase
	
	end
	
endmodule