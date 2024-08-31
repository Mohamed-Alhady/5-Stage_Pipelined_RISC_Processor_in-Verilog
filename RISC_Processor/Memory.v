module Ram(

input         CLK               ,
input 	 	  ExMem_Jump        ,
input 	 	  ExMem_Branch      ,
input 	 	  ExMem_MemRead     ,
input 	 	  ExMem_MemtoReg    ,
input         ExMem_MemWrite	,
input         ExMem_RegWrite    ,

input  [4:0]  ExMem_AluOut      ,
input  [4:0]  ExMem_AddrRdRt    ,
input  [31:0] ExMem_DataRt      ,

output reg [31:0]  MemWb_AluOut     ,
output reg [31:0] MemWb_ReadData   ,
output reg [4:0]  MemWb_AddrRdRt   ,

output 	 reg	  MemWb_MemtoReg   ,
output 	 reg	  MemWb_RegWrite    

);


reg [31:0] Memory [1023:0] ;

//reg [31:0] ReadData ;


always @(posedge CLK)
begin
	if(ExMem_MemRead)
		MemWb_ReadData <= Memory[ExMem_AluOut]   ;
	
	else if(ExMem_MemWrite)
	
				Memory[ExMem_AluOut] <=   ExMem_DataRt  ;      
		
			
		

MemWb_AluOut    	<=  ExMem_AluOut           ;
MemWb_AddrRdRt		<=  ExMem_AddrRdRt         ;
MemWb_MemtoReg		<=  ExMem_MemtoReg         ;
MemWb_RegWrite		<=  ExMem_RegWrite         ;


end 




endmodule