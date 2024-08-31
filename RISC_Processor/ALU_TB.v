module ALU_TB();

reg   	   				CLK               ;
reg   	   				Flush             ;
										  
reg   [1:0]           	FwdRs             ;
reg   [1:0]           	FwdRt             ;
										  
										  
reg   [31:0]          	Dst_FeedBack	  ;
//reg   [31:0]          	ExMem_AluOut      ;
reg          			IdEx_RegDst   	  ;
reg          			IdEx_Jump         ;
reg          			IdEx_Branch       ;
reg          			IdEx_MemRead      ;
reg          			IdEx_MemtoReg     ;
reg       [1:0]   		IdEx_Alu_Op       ;
reg          			IdEx_MemWrite     ;
reg          			IdEx_ALU_Src      ;
reg          			IdEx_RegWrite     ;
										  
reg   [31:0] 	   		IdEx_DataRs       ;
reg   [31:0] 	   		IdEx_DataRt       ;
reg   [31:0] 	   		IdEx_IMM_EX       ;
										  
reg   [4:0]  	   		IdEx_AddrRs 	  ;
reg   [4:0]  	   		IdEx_AddrRt       ;
reg   [4:0]  	   		IdEx_AddrRd       ;
 		                              
                                     
reg   [2:0 ]       		CTRL_OP           ;
										  
wire        		 	ExMem_Jump        ;
wire        		 	ExMem_Branch      ;
wire        		 	ExMem_MemRead     ;
wire        		 	ExMem_MemtoReg    ;
wire        		 	ExMem_MemWrite    ;
wire        		 	ExMem_RegWrite    ;

wire   [31:0] 	       	ExMem_DataRt 	  ;
wire   [4:0]  			ExMem_AddrRdRt	  ;								  
wire   [31:0]  			ExMem_AluOut	  ;
wire         			ExMem_ZeroFlag    ;




ALU U5(

.CLK              (CLK             )       ,
.Flush            (Flush           )       ,

.FwdRs            (FwdRs           )       ,
.FwdRt            (FwdRt           )       ,


.Dst_FeedBack	  (Dst_FeedBack	   )       ,
//.ExMem_AluOut     (ExMem_AluOut    )       ,
.IdEx_RegDst   	  (IdEx_RegDst     )       ,
.IdEx_Jump        (IdEx_Jump       )       ,
.IdEx_Branch      (IdEx_Branch     )       ,
.IdEx_MemRead     (IdEx_MemRead    )       ,
.IdEx_MemtoReg    (IdEx_MemtoReg   )       ,
.IdEx_Alu_Op      (IdEx_Alu_Op     )       ,
.IdEx_MemWrite    (IdEx_MemWrite   )       ,
.IdEx_ALU_Src     (IdEx_ALU_Src    )       ,
.IdEx_RegWrite    (IdEx_RegWrite   )       ,

.IdEx_DataRs      (IdEx_DataRs     )       ,
.IdEx_DataRt      (IdEx_DataRt     )       ,
.IdEx_IMM_EX      (IdEx_IMM_EX     )       ,

.IdEx_AddrRs 	  (IdEx_AddrRs 	   )       ,
.IdEx_AddrRt      (IdEx_AddrRt     )       ,
.IdEx_AddrRd      (IdEx_AddrRd     )       ,


.CTRL_OP          (CTRL_OP         )       ,

.ExMem_Jump       (ExMem_Jump      )       ,
.ExMem_Branch     (ExMem_Branch    )       ,
.ExMem_MemRead    (ExMem_MemRead   )       ,
.ExMem_MemtoReg   (ExMem_MemtoReg  )       ,
.ExMem_MemWrite   (ExMem_MemWrite  )       ,
.ExMem_RegWrite   (ExMem_RegWrite  )       ,

.ExMem_DataRt 	  (ExMem_DataRt 	)       ,
.ExMem_AddrRdRt	  (ExMem_AddrRdRt	)       ,
.ExMem_AluOut	  (ExMem_AluOut	    )       ,
.ExMem_ZeroFlag   (ExMem_ZeroFlag   )       

);

initial begin

$dumpfile("ALU.vcd");
$dumpvars();

CLK              <= 1'b0            ;
Flush            <= 1'b0            ;
									
FwdRs            <= 2'b00           ;
FwdRt            <= 2'b00           ;
									
									
Dst_FeedBack	 <= 32'd23            ;
//ExMem_AluOut     <= 1'b1            ;
CTRL_OP          <= 3'b000          ;
IdEx_RegDst   	 <= 1'b1            ;
IdEx_Jump        <= 1'b0            ;
IdEx_Branch      <= 1'b0            ;
IdEx_MemRead     <= 1'b0            ;
IdEx_MemtoReg    <= 1'b0            ;
//IdEx_Alu_Op      <= 2'b10           ;
IdEx_MemWrite    <= 1'b0            ;
IdEx_ALU_Src     <= 1'b0            ;
IdEx_RegWrite    <= 1'b1            ;
									
IdEx_DataRs      <= 32'd21          ;
IdEx_DataRt      <= 32'd31          ;
IdEx_IMM_EX      <= 32'd33          ;
									
IdEx_AddrRs 	 <= 5'd4            ;
IdEx_AddrRt      <= 5'd3            ;
IdEx_AddrRd      <= 5'd9            ;

#10
Flush            <= 1'b0            ;
									
FwdRs            <= 2'b00           ;
FwdRt            <= 2'b00           ;
CTRL_OP          <= 3'b000          ;																	
Dst_FeedBack	 <= 32'd54            ;
//ExMem_AluOut     <= 1'b1            ;
IdEx_RegDst   	 <= 1'b0            ;
IdEx_Jump        <= 1'b0            ;
IdEx_Branch      <= 1'b0            ;
IdEx_MemRead     <= 1'b0            ;
IdEx_MemtoReg    <= 1'b1            ;
IdEx_Alu_Op      <= 2'b10           ;
IdEx_MemWrite    <= 1'b0            ;
IdEx_ALU_Src     <= 1'b1            ;
IdEx_RegWrite    <= 1'b1            ;
									
IdEx_DataRs      <= 32'd21          ;
IdEx_DataRt      <= 32'd31          ;
IdEx_IMM_EX      <= 32'd21          ;
									
IdEx_AddrRs 	 <= 5'd9            ;
IdEx_AddrRt      <= 5'd3            ;
IdEx_AddrRd      <= 5'd9            ;

#10
Flush            <= 1'b1            ;
									
FwdRs            <= 2'b00           ;
FwdRt            <= 2'b00           ;
									
									
Dst_FeedBack	 <= 32'd54            ;
//ExMem_AluOut     <= 1'b1            ;
IdEx_RegDst   	 <= 1'b1            ;
IdEx_Jump        <= 1'b0            ;
IdEx_Branch      <= 1'b1            ;
IdEx_MemRead     <= 1'b0            ;
IdEx_MemtoReg    <= 1'b1            ;
IdEx_Alu_Op      <= 2'b00           ;
IdEx_MemWrite    <= 1'b0            ;
IdEx_ALU_Src     <= 1'b0            ;
IdEx_RegWrite    <= 1'b1            ;
									
IdEx_DataRs      <= 32'd54          ;
IdEx_DataRt      <= 32'd38          ;
IdEx_IMM_EX      <= 32'd77          ;
									
IdEx_AddrRs 	 <= 5'd3            ;
IdEx_AddrRt      <= 5'd8            ;
IdEx_AddrRd      <= 5'd3            ;

#10
Flush            <= 1'b0            ;
									
FwdRs            <= 2'b10           ;
FwdRt            <= 2'b01           ;
									
									
Dst_FeedBack	 <= 32'd17            ;
//ExMem_AluOut     <= 1'b1            ;
IdEx_RegDst   	 <= 1'b0            ;
IdEx_Jump        <= 1'b0            ;
IdEx_Branch      <= 1'b1            ;
IdEx_MemRead     <= 1'b0            ;
IdEx_MemtoReg    <= 1'b1            ;
IdEx_Alu_Op      <= 2'b00           ;
IdEx_MemWrite    <= 1'b0            ;
IdEx_ALU_Src     <= 1'b0            ;
IdEx_RegWrite    <= 1'b1            ;
									
IdEx_DataRs      <= 32'd67          ;
IdEx_DataRt      <= 32'd23          ;
IdEx_IMM_EX      <= 32'd77          ;
									
IdEx_AddrRs 	 <= 5'd3            ;
IdEx_AddrRt      <= 5'd8            ;
IdEx_AddrRd      <= 5'd3            ;




				

#100
$stop;
end

always #5 CLK = ~CLK ;

endmodule