//`timescale 1ps/1fs
module DataPath #(parameter m=32)(

//DataPath inputs    
input           CLK                     ,  
input 			RegDst                  ,
input 			Jump                    ,
input 			Branch                  ,
input 			MemRead                 ,
input 			MemtoReg                ,
input [1:0]		Alu_Op                  ,
input 			MemWrite                ,
input 			ALU_Src                 ,
input 			RegWrite                ,
input [1:0] 	FwdRs                   ,
input [1:0] 	FwdRt                   , 
input [1:0] 	Fwd_IfId_Rs             ,
input [1:0] 	Fwd_IfId_Rt             ,
input 			Flush                   ,
input       	Stall                   ,
input  [31:0]   PCT                     ,
input wire         FwdPc                ,	
	
// Data Path outputs                    
output [4:0]  IdEx_Rs                   ,
output [4:0]  IdEx_Rt                   ,
output [4:0]  ExMem_Rd                  ,
output [4:0]  MemWb_Rd                  ,
output [4:0]  ExMem_Rs                  ,
output [4:0]  ExMem_Rt                  ,
output        ExMem_Reg_Wr_Control      ,
output        MemWb_Reg_Wr_Control      ,
output [4:0]  IfId_Rs                   ,
output [4:0]  IfId_Rt                   ,
output        Ctrl_Branch               ,
output        MemWb_MemRead             ,
output  	  IdEx_MemRead              ,
output        IdEx_MemWrite             ,
output [4:0]  MemWb_Rt                  ,   
output [5:0]  OpCode                    ,
output        ExMem_ZeroFlag            

);


// Fetch Stage wires 
//wire [31:0]  UpdatedPC   ;
//reg  [31:0]  PC         ;
//wire [31:0]  PCT         ;
//wire         FwdPc       ;
 
wire [31:0]  IfId_Instr 		;
wire [31:0]  IfId_UpdatPC      ;


wire [15:0]  IMM_N        ;
wire [4:0 ]  AddrRegWr    ;
wire [31:0]  DataWrite    ;

//wires for output from Decode Stage 

//wire [15:0]  IMM_N        ;
//wire [4:0 ]  AddrRegWr    ;
//wire [31:0]  DataWrite    ;

//Data Forwarded From EeMem and MemWb Stages as an input instead of Decode
//For solving data Hazard due to Branching

wire  [31:0]  MemWbFwdData     ;
wire  [31:0]  ExMemFwdData     ;

//outs
wire        IdEx_RegDst           ;
wire 		IdEx_Jump             ;
wire 		IdEx_Branch           ;
//wire 		IdEx_MemRead          ;
wire 		IdEx_MemtoReg         ;
wire [1:0]  IdEx_Alu_Op	          ;
//wire 		IdEx_MemWrite         ;
wire 		IdEx_RegWrite         ;
wire        IdEx_ALU_Src          ;
wire [31:0] IdEx_DataRs           ;
wire [31:0] IdEx_DataRt           ;
wire [31:0] IdEx_IMM_EX           ;
								  
wire [4:0]  IdEx_AddrRs           ;
wire [4:0]  IdEx_AddrRt           ;
wire [4:0]  IdEx_AddrRd           ;

// ALUControl WIREs 

wire [2:0]  CTRL_OP           ;    

// ALU Wires   
wire [m-1:0] AluRs       ;
wire [31:0] AluRt       ;


// Execution Stage Wires 


//wire [31:0]    Alu_DataRs ;
//wire [31:0]    Alu_DataRt ;


wire        ExMem_Jump             ;
wire       	ExMem_Branch           ;
wire       	ExMem_MemRead          ;
wire       	ExMem_MemtoReg         ;
wire       	ExMem_MemWrite         ;
wire       	ExMem_RegWrite         ;
//wire [31:0] ExMem_AluOut           ;
//wire [31:0] ExMem_Rt               ;
//wire [4:0]  ExMem_AddrRdRt         ;


// Memory WritBack  Stage Wires 


wire [m-1:0]  	ExMem_AluOut       ;
wire [4:0]   	ExMem_AddrRdRt     ;
wire [31:0]  	ExMem_DataRt       ;

wire [31:0] 	MemWb_AluOut       ;
wire [31:0] 	MemWb_ReadData     ;
wire [4:0]  	MemWb_AddrRdRt     ;

wire 	 	  	MemWb_MemtoReg     ;
wire 	 	  	MemWb_RegWrite     ;


wire [31:0] Dst_FeedBack           ;                 








//assign IdExRs 	 = IfId_Instr[25:21];
//assign IdExRt 	 = IfId_Instr[20:16];
//assign ExMemRd 	 = IfId_Instr[15:11];
//assign MemWbRd     = IfId_Instr[15:11];
//assign MemWbRt     = IfId_Instr[20:16];
//assign ExMemOp     = IfId_Instr[31:26];
//assign MemWbOp     = IfId_Instr[31:26];
//assign IdExOp      = IfId_Instr[31:26];

assign IMM_N = IfId_Instr[0];


//mux3x1 #(32) D0(
//
//.in1		(UpdatedPC  			    ) ,
//.in2        (PCT						) ,
//.in3		(PC                         ) ,
//.sel        ({(Stall | Flush) , FwdPc}  ) ,
//.out1       (PC 		                ) 
//
//);

IMEM D1(

.PCT                (PCT  	        ) 	,
.CLK                (CLK  			)   ,
.IfId_Instr         (IfId_Instr     )   ,
.IfId_UpdatPC       (IfId_UpdatPC   )   ,
//.UpdatedPC          (UpdatedPC      )   ,
.Stall              (Stall          )   ,
.Flush              (Flush          )   ,
.FwdPc              (FwdPc          )
);

OPREG D2(

.CLK                  (CLK              )	   ,
.Stall                (Stall            )      ,
.AddrRs               (IfId_Instr[25:21])      ,
.AddrRt               (IfId_Instr[20:16])      ,
.AddrRd               (IfId_Instr[15:11])      ,
.AddrRegWr            (ExMem_AddrRdRt	)      ,
.DataWrite            (Dst_FeedBack		)      ,
.PC                   (IfId_UpdatPC    )      ,
.IMM_N                (IfId_Instr[15:0] )      ,
.RegDst               (RegDst   		)      ,
.Jump                 (Jump     		)      ,
.Branch               (Branch   		)      ,
.MemRead              (MemRead  		)      ,
.MemtoReg             (MemtoReg 		)      ,
.Alu_Op               (Alu_Op   		)      ,
.MemWrite             (MemWrite 		)      ,
.ALU_Src              (ALU_Src  		)      ,
.RegWrite             (RegWrite 		)      ,
.MemWbFwdData         (Dst_FeedBack		)      ,
.ExMemFwdData         (ExMem_AluOut		)      ,
					  

.Fwd_IfId_Rs          (Fwd_IfId_Rs		)      ,
.Fwd_IfId_Rt	      (Fwd_IfId_Rt		)      ,	  
.PCT                  (PCT              )      ,
.IdEx_RegDst          (IdEx_RegDst      )      ,
.IdEx_Jump            (IdEx_Jump    	)      ,
.IdEx_Branch          (IdEx_Branch  	)      ,
.IdEx_MemRead         (IdEx_MemRead 	)      ,
.IdEx_MemtoReg        (IdEx_MemtoReg	)      ,
.IdEx_Alu_Op          (IdEx_Alu_Op      )      ,
.IdEx_MemWrite        (IdEx_MemWrite	)      ,
.IdEx_ALU_Src         (IdEx_ALU_Src     )      ,
.IdEx_RegWrite        (IdEx_RegWrite	)      ,
.IdEx_DataRs          (IdEx_DataRs  	)      ,
.IdEx_DataRt          (IdEx_DataRt  	)      ,
.IdEx_IMM_EX          (IdEx_IMM_EX  	)      ,
.IdEx_AddrRs          (IdEx_AddrRs		)      ,
.IdEx_AddrRt          (IdEx_AddrRt		)      ,
.IdEx_AddrRd          (IdEx_AddrRd		)      


);


ALU  D4(

.CLK        		(CLK        	)		,
.Flush              (Flush          )       ,
					
.IdEx_DataRs        (IdEx_DataRs		)		,
.IdEx_DataRt        (IdEx_DataRt		)		,
.IdEx_IMM_EX        (IdEx_IMM_EX   )		,

.FwdRs              (FwdRs          )		,
.FwdRt              (FwdRt          )		,
.Dst_FeedBack       (Dst_FeedBack   )		,
					
.IdEx_RegDst        (IdEx_RegDst     )		,
.IdEx_Jump    	    (IdEx_Jump    	 )		,
.IdEx_Branch        (IdEx_Branch     )		,
.IdEx_MemRead       (IdEx_MemRead    )		,
.IdEx_MemtoReg      (IdEx_MemtoReg   )		,
//.IdEx_Alu_Op        (IdEx_Alu_Op     )		,
.IdEx_MemWrite      (IdEx_MemWrite   )		,
.IdEx_ALU_Src       (IdEx_ALU_Src    )		,
.IdEx_RegWrite      (IdEx_RegWrite   )		,
.IdEx_AddrRs        (IdEx_AddrRs 	 )		,
.IdEx_AddrRt        (IdEx_AddrRt 	 )		,
.IdEx_AddrRd        (IdEx_AddrRd 	 )		,

.CTRL_OP            (CTRL_OP         )		,

.ExMem_Jump         (ExMem_Jump    	 )		,
.ExMem_Branch       (ExMem_Branch  	 )		,
.ExMem_MemRead      (ExMem_MemRead 	 )		,
.ExMem_MemtoReg     (ExMem_MemtoReg	 )		,
.ExMem_MemWrite     (ExMem_MemWrite	 )		,
.ExMem_RegWrite     (ExMem_RegWrite	 )		,
.ExMem_AddrRdRt     (ExMem_AddrRdRt	 )		,
.ExMem_AluOut       (ExMem_AluOut  	 )		,
.ExMem_ZeroFlag     (ExMem_ZeroFlag	 )		,
.ExMem_DataRt       (ExMem_DataRt    )



);

AluCtrl D51(

.AluOp         (IdEx_Alu_Op          )   ,
.AluFun        (IdEx_IMM_EX[3:0])   ,
.CTRL_OP       (CTRL_OP       )  

);



//mux3x1 D5(
//
//.in1        (IdEx_DataRs  )		,
//.in2        (Dst_FeedBack )		,
//.in3        (ExMem_AluOut )		,
//.sel	    (FwdRs        )		,
//.out1       (Alu_DataRs   ) 
//
//);
//
//mux3x1 D6(
//
//.in1        (IdEx_DataRt 	)     ,
//.in2        (Dst_FeedBack	)     ,
//.in3        (ExMem_AluOut	)     ,
//.sel        (FwdRt       	)     ,
//.out1       (Alu_DataRt  	)
//
//);
//
//mux2x1 D7(
//
//.in1	(IdEx_AddrRt)    ,
//.in2    (IdEx_AddrRd)    ,
//.sel    (IdEx_RegDst)    ,
//.out1   (Dest_RdRt)    
//
//
//);

Ram D8(

.CLK                (CLK           )  , 
.ExMem_Jump       	(ExMem_Jump    )  ,
.ExMem_Branch       (ExMem_Branch  )  ,
.ExMem_MemRead      (ExMem_MemRead )  ,
.ExMem_MemtoReg     (ExMem_MemtoReg)  ,
.ExMem_MemWrite     (ExMem_MemWrite)  ,
.ExMem_RegWrite     (ExMem_RegWrite)  ,

.ExMem_AluOut       (ExMem_AluOut  )  ,
.ExMem_AddrRdRt     (ExMem_AddrRdRt)  ,
.ExMem_DataRt       (ExMem_DataRt  )  ,
		
.MemWb_AluOut       (MemWb_AluOut  )  ,
.MemWb_ReadData     (MemWb_ReadData)  ,
.MemWb_AddrRdRt     (MemWb_AddrRdRt)  ,
				
.MemWb_MemtoReg     (MemWb_MemtoReg)  ,
.MemWb_RegWrite     (MemWb_RegWrite)  

);




mux2x1 #(32,32) D7(

.in1	(MemWb_ReadData)    ,
.in2    (MemWb_AluOut  )    ,
.sel    (MemWb_MemtoReg)    ,
.out1   (Dst_FeedBack  )    


);

endmodule