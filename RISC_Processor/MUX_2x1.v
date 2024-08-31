module mux2x1 #(parameter SIZE = 1, WIDTH = 1)(

input [SIZE-1 : 0]  in1            ,
input [WIDTH-1 : 0]  in2            ,
input sel            ,

output reg [SIZE-1 : 0]     out1


);


always @(*) 
begin 
	case (sel)
	
		1'b0	:
			out1 <= in1 ;
		1'b1    :
			out1 <= in2 ;
		default :
			out1 <= 'bx ;
	endcase
	end 


endmodule