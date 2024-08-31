module IMEM_TB;

reg [31:0]  PC       		;
reg 		CLK      		;
reg 		Stall    		;
reg 		Flush    		;

wire [31:0] IfId_Instr    ;
wire [31:0] IfId_UpdatPC  ;
wire [31:0] UpdatedPC     ;





IMEM U0(

.PC       	      (PC       	)    ,
.CLK      	      (CLK      	)    ,
.Stall    	      (Stall    	)    ,
.Flush    	      (Flush    	)    ,

.IfId_Instr       (IfId_Instr  )    ,
.IfId_UpdatPC     (IfId_UpdatPC)    ,
.UpdatedPC        (UpdatedPC   )    

);


initial begin

$dumpfile("MEM.vcd");
$dumpvars();

PC      <= 32'd2 ;
CLK     <= 1'b0  ;
Stall   <= 1'b0  ;
Flush   <= 1'b0  ;


#10

PC     <= 32'd4 ;
Stall  <= 1'b0  ;
Flush  <= 1'b0  ;
       


#10

PC     <= 32'd6 ;
Stall  <= 1'b1  ;
Flush  <= 1'b0  ;





#100;
$stop ;


end 

always #5 CLK <= ~ CLK;

endmodule