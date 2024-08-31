
// Execution Stage 

module ALU #(parameter size = 32)(


input  			   			CLK                      ,    
input 			   			Flush                    ,

input   	[1:0]           FwdRs                    ,
input   	[1:0]           FwdRt                    ,
				
	
input   	[31:0]          Dst_FeedBack			 ,
//input  		[size-1:0]      ExMem_AluOut             ,
input              			IdEx_RegDst   			 ,
input              			IdEx_Jump                ,
input              			IdEx_Branch              ,
input              			IdEx_MemRead             ,
input              			IdEx_MemtoReg            ,
input       [1:0]           IdEx_Alu_Op              ,
input              			IdEx_MemWrite            ,
input              			IdEx_ALU_Src             ,
input              			IdEx_RegWrite            ,
		
input       [31:0] 	   		IdEx_DataRs              ,
input       [31:0] 	   		IdEx_DataRt              ,
input       [31:0] 	   		IdEx_IMM_EX 			 ,
		    	
input       [4:0]  	   		IdEx_AddrRs 			 ,
input       [4:0]  	   		IdEx_AddrRt              ,
input       [4:0]  	   		IdEx_AddrRd              ,
		
		    
input  wire     [2:0 ]       CTRL_OP                  ,   
		
output reg         		 	ExMem_Jump               ,
output reg         		 	ExMem_Branch             ,
output reg         		 	ExMem_MemRead            ,
output reg         		 	ExMem_MemtoReg           ,
output reg         		 	ExMem_MemWrite           ,
output reg         		 	ExMem_RegWrite           ,

//output reg  [31:0] ExMem_DataRs 
output reg  [31:0] 	       	ExMem_DataRt 			,
//output reg  [31:0] ExMem_IMM_EX 
 
//output reg  [4:0] ExMem_AddrRs 
//output reg  [4:0] ExMem_AddrRt 
output reg  [4:0]  			ExMem_AddrRdRt			,
		
		
output  reg       [size-1:0]    ExMem_AluOut			,
output  reg            		ExMem_ZeroFlag

);

//wire  [2:0 ]       CTRL_OP_T  ;

reg [31:0]  ALU_OUT	      ;
wire         ZeroFlag      ;
wire [4:0]  Dest_RdRt     ;
wire [31:0]	Alu_DataRs    ;	
wire [31:0]	Alu_DataRt    ;
wire [31:0] mux_out       ;

assign ZeroFlag = (ALU_OUT == 32'd0)? 1'b1 : 1'b0 ;
//assign CTRL_OP  = CTRL_OP_T; 
always @(*)
	begin
	
		case (CTRL_OP)
		3'b000 : ALU_OUT <= Alu_DataRs + mux_out					;
		3'b001 : ALU_OUT <= Alu_DataRs - mux_out					;
		3'b010 : ALU_OUT <= Alu_DataRs & mux_out					;
		3'b011 : ALU_OUT <= Alu_DataRs | mux_out					;
		3'b100 : ALU_OUT <=(Alu_DataRs < mux_out)? 32'd1 : 32'd0   ;
		default: ALU_OUT <= Alu_DataRs + mux_out					;
	endcase
	end

always @(posedge CLK)

begin

	if(Flush)
		begin
		
			ExMem_Jump        <= 1'b0       ;  
		    ExMem_Branch      <= 1'b0       ;
		    ExMem_MemRead     <= 1'b0       ;
		    ExMem_MemtoReg    <= 1'b0       ;
		    ExMem_MemWrite    <= 1'b0       ;
		    ExMem_RegWrite    <= 1'b0       ;
		
		end

	else
		begin
		
			ExMem_Jump      <= IdEx_Jump         ;
		    ExMem_Branch    <= IdEx_Branch       ;
		    ExMem_MemRead   <= IdEx_MemRead      ;
		    ExMem_MemtoReg  <= IdEx_MemtoReg     ;
		    ExMem_MemWrite  <= IdEx_MemWrite     ;
		    ExMem_RegWrite  <= IdEx_RegWrite     ;
		
		end
	
	
	  
		ExMem_AluOut       <= ALU_OUT	    ;
	    ExMem_ZeroFlag     <= ZeroFlag      ;
		ExMem_AddrRdRt     <= Dest_RdRt     ;
	
		ExMem_DataRt       <= Alu_DataRt   ;






end


mux2x1 #(5,5) U8 (

.in1	(IdEx_AddrRt)    ,
.in2    (IdEx_AddrRd)    ,
.sel    (IdEx_RegDst)    ,
.out1   (Dest_RdRt)    


);


mux3x1 #(32) U9 (

.in1        (IdEx_DataRs  )			,
.in2        (Dst_FeedBack )         ,
.in3        (ExMem_AluOut )         ,
.sel	    (FwdRs        )         ,
.out1       (Alu_DataRs   ) 

);

mux3x1 #(32) U10(

.in1        (IdEx_DataRt 	)		,
.in2        (Dst_FeedBack	)       ,
.in3        (ExMem_AluOut	)       ,
.sel        (FwdRt       	)       ,
.out1       (Alu_DataRt  	)

);

mux2x1 #(32,32) U11 (

.in1		(Alu_DataRt  )       ,
.in2    	(IdEx_IMM_EX )       ,
.sel    	(IdEx_ALU_Src)       ,
.out1   	(mux_out     )    


);













endmodule 