//`timescale 1ps/1fs
module DATAPATH_TB();

reg           	CLK           		;
reg 			RegDst              ;
reg 			Jump                ;
reg 			Branch              ;
reg 			MemRead             ;
reg 			MemtoReg            ;
reg [1:0]		Alu_Op              ;
reg 			MemWrite            ;
reg 			ALU_Src             ;
reg 			RegWrite            ;
reg [1:0] 		FwdRs               ;
reg [1:0] 		FwdRt               ;
reg [1:0] 		Fwd_IfId_Rs         ;
reg [1:0] 		Fwd_IfId_Rt         ;
reg 			Flush               ;
reg       		Stall               ;
reg [31:0]      PCT                 ;
reg            FwdPc               ;

									
wire [4:0]      IdEx_Rs                 ;
wire [4:0]      IdEx_Rt                 ;
wire [4:0]      ExMem_Rd                ;
wire [4:0]      MemWb_Rd                ;
wire [4:0]      ExMem_Rs                ;
wire [4:0]      ExMem_Rt                ;
wire            ExMem_Reg_Wr_Control    ;
wire            MemWb_Reg_Wr_Control    ;
wire [4:0]      IfId_Rs                 ;
wire [4:0]      IfId_Rt                 ;
wire            Ctrl_Branch             ;
wire            MemWb_MemRead           ;
wire  	        IdEx_MemRead            ;
wire            IdEx_MemWrite           ;
wire [4:0]      MemWb_Rt                ;
wire [5:0]      OpCode                  ;
wire            ExMem_ZeroFlag          ;


DataPath DUT1(

.CLK           			 (CLK           	  )      ,		
.RegDst                  (RegDst              )      ,
.Jump                    (Jump                )      ,
.Branch                  (Branch              )      ,
.MemRead                 (MemRead             )      ,
.MemtoReg                (MemtoReg            )      ,
.Alu_Op                  (Alu_Op              )      ,
.MemWrite                (MemWrite            )      ,
.ALU_Src                 (ALU_Src             )      ,
.RegWrite                (RegWrite            )      ,
.FwdRs                   (FwdRs               )      ,
.FwdRt                   (FwdRt               )      ,
.Fwd_IfId_Rs             (Fwd_IfId_Rs         )      ,
.Fwd_IfId_Rt             (Fwd_IfId_Rt         )      ,
.Flush                   (Flush               )      ,
.Stall                   (Stall               )      ,
.PCT                     (PCT                  )      ,
.FwdPc                   (FwdPc)               ,

.IdEx_Rs                 (IdEx_Rs             )      ,
.IdEx_Rt                 (IdEx_Rt             )      ,
.ExMem_Rd                (ExMem_Rd            )      ,
.MemWb_Rd                (MemWb_Rd            )      ,
.ExMem_Rs                (ExMem_Rs            )      ,
.ExMem_Rt                (ExMem_Rt            )      ,
.ExMem_Reg_Wr_Control    (ExMem_Reg_Wr_Control)      ,
.MemWb_Reg_Wr_Control    (MemWb_Reg_Wr_Control)      ,
.IfId_Rs                 (IfId_Rs             )      ,
.IfId_Rt                 (IfId_Rt             )      ,
.Ctrl_Branch             (Ctrl_Branch         )      ,
.MemWb_MemRead           (MemWb_MemRead       )      ,
.IdEx_MemRead            (IdEx_MemRead        )      ,
.IdEx_MemWrite           (IdEx_MemWrite       )      ,
.MemWb_Rt                (MemWb_Rt            )      ,
.OpCode                  (OpCode              )      ,
.ExMem_ZeroFlag          (ExMem_ZeroFlag      )      

);









initial begin

$dumpfile("dataPath.vcd");
$dumpvars();

CLK         	<=1'b0		;
RegDst          <=1'b0      ;
Jump            <=1'b0      ;
Branch          <=1'b0      ;
MemRead         <=1'b0      ;
MemtoReg        <=1'b0      ;
Alu_Op          <=2'b00     ;
MemWrite        <=1'b0      ;
ALU_Src         <=1'b0      ;
RegWrite        <=1'b0      ;
FwdRs           <=2'b00     ;
FwdRt           <=2'b00     ;
Fwd_IfId_Rs     <=2'b00     ;
Fwd_IfId_Rt     <=2'b00     ;
Flush           <=1'b0      ;
Stall           <=1'b0      ;
PCT             <=32'd3     ;
FwdPc           <=1'b0      ; 

#10
RegDst          <=1'b1      ;
Jump            <=1'b0      ;
Branch          <=1'b0      ;
MemRead         <=1'b1      ;
MemtoReg        <=1'b1      ;
Alu_Op          <=2'b10     ;
MemWrite        <=1'b0      ;
ALU_Src         <=1'b0      ;
RegWrite        <=1'b0      ;
FwdRs           <=2'b10     ;
FwdRt           <=2'b01     ;
Fwd_IfId_Rs     <=2'b00     ;
Fwd_IfId_Rt     <=2'b00     ;
Flush           <=1'b0      ;
Stall           <=1'b0      ;
//PC_IN           <=32'd2     ;

#10
RegDst          <=1'b0      ;
Jump            <=1'b0      ;
Branch          <=1'b1      ;
MemRead         <=1'b1      ;
MemtoReg        <=1'b1      ;
Alu_Op          <=2'b00     ;
MemWrite        <=1'b0      ;
ALU_Src         <=1'b0      ;
RegWrite        <=1'b1      ;
FwdRs           <=2'b00     ;
FwdRt           <=2'b00     ;
Fwd_IfId_Rs     <=2'b00     ;
Fwd_IfId_Rt     <=2'b00     ;
Flush           <=1'b0      ;
Stall           <=1'b0      ;
FwdPc           <=1'b1      ;


#10
RegDst          <=1'b0      ;
Jump            <=1'b0      ;
Branch          <=1'b1      ;
MemRead         <=1'b1      ;
MemtoReg        <=1'b1      ;
Alu_Op          <=2'b10     ;
MemWrite        <=1'b0      ;
ALU_Src         <=1'b0      ;
RegWrite        <=1'b1      ;
FwdRs           <=2'b00     ;
FwdRt           <=2'b00     ;
Fwd_IfId_Rs     <=2'b00     ;
Fwd_IfId_Rt     <=2'b00     ;
Flush           <=1'b1      ;
Stall           <=1'b0      ;
FwdPc           <=1'b0      ;






#100
$stop;


end

always #5 CLK= !CLK;

endmodule




