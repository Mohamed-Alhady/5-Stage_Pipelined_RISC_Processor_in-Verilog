module Memory_TB();

reg        CLK             ;
reg	 	   ExMem_Jump       ;
reg	 	   ExMem_Branch     ;
reg	 	   ExMem_MemRead    ;
reg	 	   ExMem_MemtoReg   ;
reg        ExMem_MemWrite  ;
reg        ExMem_RegWrite  ;

reg [4:0]  ExMem_AluOut    ;
reg [4:0]  ExMem_AddrRdRt  ;
reg [31:0] ExMem_DataRt    ;
				
wire [4:0] MemWb_AluOut   	 ;
wire [31:0] MemWb_ReadData   ;
wire [4:0]  MemWb_AddrRdRt   ;
							 
wire 	 	  MemWb_MemtoReg ; 
wire 	 	  MemWb_RegWrite ; 


Ram DUT0(

.CLK               (CLK            )   ,
.ExMem_Jump        (ExMem_Jump     )   ,
.ExMem_Branch      (ExMem_Branch   )   ,
.ExMem_MemRead     (ExMem_MemRead  )   ,
.ExMem_MemtoReg    (ExMem_MemtoReg )   ,
.ExMem_MemWrite    (ExMem_MemWrite )   ,
.ExMem_RegWrite    (ExMem_RegWrite )   ,
				 
.ExMem_AluOut      (ExMem_AluOut   )   ,
.ExMem_AddrRdRt    (ExMem_AddrRdRt )   ,
.ExMem_DataRt      (ExMem_DataRt   )   ,

.MemWb_AluOut      (MemWb_AluOut  )   ,
.MemWb_ReadData    (MemWb_ReadData)   ,
.MemWb_AddrRdRt    (MemWb_AddrRdRt)   ,
				  
.MemWb_MemtoReg    (MemWb_MemtoReg)   ,
.MemWb_RegWrite    (MemWb_RegWrite)   



);

initial begin

$dumpfile("Ram.vcd");
$dumpvars();

CLK             <= 1'b0     ;
ExMem_Jump     	<= 1'b0		;
ExMem_Branch    <= 1'b0     ;
ExMem_MemRead   <= 1'b0     ;
ExMem_MemtoReg  <= 1'b0     ;
ExMem_MemWrite  <= 1'b1     ;
ExMem_RegWrite  <= 1'b1     ;
							
ExMem_AluOut    <= 5'd9     ;
ExMem_AddrRdRt  <= 5'd23    ;
ExMem_DataRt    <= 32'd65   ;


#10

ExMem_Jump     	<= 1'b0		;
ExMem_Branch    <= 1'b0     ;
ExMem_MemRead   <= 1'b0     ;
ExMem_MemtoReg  <= 1'b0     ;
ExMem_MemWrite  <= 1'b1     ;
ExMem_RegWrite  <= 1'b1     ;
							
ExMem_AluOut    <= 5'd29     ;
ExMem_AddrRdRt  <= 5'd23    ;
ExMem_DataRt    <= 32'd34   ;

#10

ExMem_Jump     	<= 1'b0		;
ExMem_Branch    <= 1'b0     ;
ExMem_MemRead   <= 1'b1     ;
ExMem_MemtoReg  <= 1'b0     ;
ExMem_MemWrite  <= 1'b0     ;
ExMem_RegWrite  <= 1'b1     ;
							
ExMem_AluOut    <= 5'd29     ;
ExMem_AddrRdRt  <= 5'd23    ;
ExMem_DataRt    <= 32'd65   ;

#10

ExMem_Jump     	<= 1'b0		;
ExMem_Branch    <= 1'b0     ;
ExMem_MemRead   <= 1'b1     ;
ExMem_MemtoReg  <= 1'b0     ;
ExMem_MemWrite  <= 1'b0     ;
ExMem_RegWrite  <= 1'b1     ;
							
ExMem_AluOut    <= 5'd9     ;
ExMem_AddrRdRt  <= 5'd23    ;
ExMem_DataRt    <= 32'd65   ;

#10

ExMem_Jump     	<= 1'b0		;
ExMem_Branch    <= 1'b0     ;
ExMem_MemRead   <= 1'b1     ;
ExMem_MemtoReg  <= 1'b0     ;
ExMem_MemWrite  <= 1'b0     ;
ExMem_RegWrite  <= 1'b1     ;
							
ExMem_AluOut    <= 5'd25     ;
ExMem_AddrRdRt  <= 5'd23    ;
ExMem_DataRt    <= 32'd65   ;




#100
$stop;

end

always #5 CLK = !CLK ;


endmodule