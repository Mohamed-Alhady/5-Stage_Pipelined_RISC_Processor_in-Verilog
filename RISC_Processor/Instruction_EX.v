
// Decoding Stage 
module OPREG #(parameter width = 32)(

input         CLK             ,
//Addresses for accessing registrer fields 
input [4:0]   AddrRs          , 
input [4:0]   AddrRt          ,
input [4:0]   AddrRd          ,
input [4:0]   AddrRegWr       ,

input [31:0]  DataWrite       ,
input [31:0]  PC              ,
input [15:0]  IMM_N           , // 15 Bit Immediate Value
input         Stall           ,

// Controls Input 

input         RegDst          ,
input         Jump            ,
input         Branch          ,
input         MemRead         ,
input         MemtoReg        ,
input [1:0]   Alu_Op          ,
input         MemWrite        ,
input         ALU_Src         ,
input         RegWrite        ,

input [31:0]  MemWbFwdData    ,
input [31:0]  ExMemFwdData    ,
input [1:0 ]  Fwd_IfId_Rs     ,
input [1:0 ]  Fwd_IfId_Rt     ,

//outs//
output wire   [31:0] PCT      ,

// output Controls

output  reg   		IdEx_RegDst  		,
output  reg   		IdEx_Jump           ,
output  reg   		IdEx_Branch         ,
output  reg   		IdEx_MemRead        ,
output  reg   		IdEx_MemtoReg       ,
output  reg [1:0]   IdEx_Alu_Op         ,
output  reg   		IdEx_MemWrite       ,
output  reg   		IdEx_ALU_Src        ,
output  reg   		IdEx_RegWrite       ,
    
// outputs of ID/EX pipeline Register 
output reg    [width-1:0] IdEx_DataRs   		,
output reg    [31:0]	  IdEx_DataRt   		,
output reg    [31:0]	  IdEx_IMM_EX   		,
		 
output reg    [4:0] 	  IdEx_AddrRs 		,
output reg    [4:0] 	  IdEx_AddrRt 		,
output reg    [4:0] 	  IdEx_AddrRd

);

reg   [31:0]   		IMM[1023:0]  		;
wire  [31:0]   		IMM_EX_I     		;
wire  [width-1:0]   DataRs       		;
wire  [31:0]   		DataRt       		;
wire  [4:0 ]   		DATA_RS             ;       


//assign DataRs             = IMM[AddrRs]                            			;
//assign DataRt             = IMM[AddrRt]                            			;
//assign IMM[AddrRegWr]     = (RegWrite)  ? DataWrite : IMM[AddrRegWr]        ;
assign IMM_EX_I           ={{16{IMM_N[15]}}, IMM_N[15:0]}          		    ; 

assign PCT       =  PC +(IMM_N<<2) ;
assign AddrRegWr = (RegDst) ? AddrRd : AddrRt;

always @(posedge CLK)

begin 
	if(Stall)
		begin
			IdEx_RegDst          <=  1'b0    ;   
			IdEx_Jump            <=  1'b0    ;   
			IdEx_Branch          <=  1'b0    ;   
			IdEx_MemRead         <=  1'b0    ;   
			IdEx_MemtoReg        <=  1'b0    ;   
			IdEx_Alu_Op          <=  2'b0	 ;   
			IdEx_MemWrite 		 <=  1'b0    ;
			IdEx_ALU_Src         <=  1'b0    ;
			IdEx_RegWrite        <=  1'b0    ;
		end
	else 
		begin
		
			IdEx_RegDst          <=  RegDst        ; 
			IdEx_Jump            <=  Jump          ; 
			IdEx_Branch          <=  Branch        ; 
		    IdEx_MemRead         <=  MemRead       ; 
		    IdEx_MemtoReg        <=  MemtoReg      ; 
		    IdEx_Alu_Op          <=  Alu_Op    	   ; 
		    IdEx_MemWrite 		 <=  MemWrite      ;
		    IdEx_ALU_Src         <=  ALU_Src       ;
		    IdEx_RegWrite        <=  RegWrite      ;
		
		end
	IMM[AddrRegWr]       <= (RegWrite)  ? DataWrite : IMM[AddrRegWr]        ;
	IdEx_DataRs			 <=	 DATA_RS           ;
	IdEx_DataRt          <=  DataRt            ;
	
	IdEx_IMM_EX          <=  IMM_EX_I          ;
	
	IdEx_AddrRs          <=  AddrRs            ;
	IdEx_AddrRt          <=  AddrRt            ;
	IdEx_AddrRd          <=  AddrRd            ;
	



end 



mux3x1 #(32) U7(

.in1		(IMM[AddrRs]   	)	,
.in2        (MemWbFwdData	)   ,
.in3        (ExMemFwdData	)   ,
.sel        (Fwd_IfId_Rs	)   ,
.out1       (DataRs 	    )

);


mux3x1 #(32) U8(

.in1		(IMM[AddrRt]   	)	,
.in2        (MemWbFwdData	)   ,
.in3        (ExMemFwdData	)   ,
.sel        (Fwd_IfId_Rt	)   ,
.out1       (DataRt 	    )

);

// in load case to select the memory addr
mux2x1 #(32,32) U15 (

.in1	(DataRs     )    ,
.in2    (AddrRs     )    ,
.sel    (MemRead    )    ,
.out1   (DATA_RS    )    


);




endmodule