module IMEM (

//// inputs ////
input  [31:0] PCT        					,
input 		 CLK           					,
input 		 Stall                          , 
input        Flush 							,
input		 FwdPc			                ,
//// Outputs ////

output reg [31:0] IfId_Instr, IfId_UpdatPC	 
//output     [31:0] UpdatedPC 

);

//wire [31:0] UpdatedPC ;

wire [31:0] Instr ;
reg [32:0]IR [1024:0] ;

reg  [31:0] PC =0             ;
assign Instr = IR[PC>>2]	;
//assign UpdatedPC =  PC + 4	;


initial
	begin
	
	$readmemh("instructions.txt", IR);
	//PC = 0   ;
	end


always @(posedge CLK)
begin
			
			IfId_Instr     <= (Stall | Flush )? 32'd0 : Instr       ;
		    IfId_UpdatPC	<=  PC     ;
		
		
end

always @(posedge CLK)
begin
//PC <=32'b0 ;
case({(Stall | Flush) , FwdPc})
	2'b00 : 
		PC <= PC +4 ;
	2'b01 :
		PC <= PCT ;
	2'b10 :
		PC <= PC       ;
	default: PC <= PC+4 ;
	endcase
end





endmodule 