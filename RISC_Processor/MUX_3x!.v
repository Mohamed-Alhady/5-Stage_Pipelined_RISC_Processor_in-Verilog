module mux3x1 #(parameter WIDTH = 1)(

input 	[WIDTH-1 : 0]	in1            ,
input 	[WIDTH-1 : 0]	in2            ,
input 	[WIDTH-1 : 0]	in3            ,

input   [1:0] sel                      ,

output reg [WIDTH-1 : 0] out1


);


always @(*) 
begin 
	case (sel)
	
		2'b00	:
			out1 <= in1 ;
		2'b01    :
			out1 <= in2 ;
		
		2'b10   :
			out1<= in3  ;
		
		default :
			out1 <= 'bx ;
	endcase
	end 


endmodule