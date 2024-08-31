module Forward_Unit_TB();

reg [4:0] IdEx_Rs                ;  
reg [4:0] IdEx_Rt                ; 
reg [4:0] ExMem_Rd               ; 
reg [4:0] MemWb_Rd               ; 
reg [4:0] ExMem_Rs               ; 
reg [4:0] ExMem_Rt               ; 
reg       ExMem_Reg_Wr_Control   ; 
reg       MemWb_Reg_Wr_Control   ; 

reg [4:0] IfId_Rs                ;
reg [4:0] IfId_Rt                ;
reg       Ctrl_Branch            ;
reg       MemWb_MemRead          ;

wire[1:0] FwdRs                        ;
wire[1:0] FwdRt                        ;
wire      FwdPc                        ;
wire[1:0] Fwd_IfId_Rs, Fwd_IfId_Rt     ;





Forward_Unit U4(

.IdEx_Rs                   (IdEx_Rs             )  , 
.IdEx_Rt                   (IdEx_Rt             )  ,
.ExMem_Rd                  (ExMem_Rd            )  ,
.MemWb_Rd                  (MemWb_Rd            )  ,
.ExMem_Rs                  (ExMem_Rs            )  ,
.ExMem_Rt                  (ExMem_Rt            )  ,
.ExMem_Reg_Wr_Control      (ExMem_Reg_Wr_Control)  ,
.MemWb_Reg_Wr_Control      (MemWb_Reg_Wr_Control)  ,
.IfId_Rs                   (IfId_Rs             )  ,
.IfId_Rt                   (IfId_Rt             )  ,
.Ctrl_Branch               (Ctrl_Branch         )  ,
.MemWb_MemRead             (MemWb_MemRead       )  ,
.FwdRs                     (FwdRs               )  ,
.FwdRt                     (FwdRt               )  ,
.FwdPc                     (FwdPc               )  ,
.Fwd_IfId_Rs               (Fwd_IfId_Rs         )  ,
.Fwd_IfId_Rt               (Fwd_IfId_Rt         )



);

initial begin

$dumpfile("FWD_UNIT.vcd");
$dumpvars();


IdEx_Rs                    = 5'b11011       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b11011       ;
MemWb_Rd                   = 5'b00000       ;
ExMem_Rs                   = 5'b01110       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b0           ;
IfId_Rs                    = 5'b00000       ;
IfId_Rt                    = 5'b00000       ;
Ctrl_Branch                = 1'b0           ;
MemWb_MemRead              = 1'b0           ;


#10

IdEx_Rs                    = 5'b11011       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b00000       ;
MemWb_Rd                   = 5'b11011       ;
ExMem_Rs                   = 5'b01110       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b1           ;
IfId_Rs                    = 5'b00000       ;
IfId_Rt                    = 5'b00000       ;
Ctrl_Branch                = 1'b0           ;
MemWb_MemRead              = 1'b0           ;


#10						 

IdEx_Rs                    = 5'b00000       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b11011       ;
MemWb_Rd                   = 5'b00000       ;
ExMem_Rs                   = 5'b01110       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b0           ;
IfId_Rs                    = 5'b10101       ;
IfId_Rt                    = 5'b10101       ;
Ctrl_Branch                = 1'b1           ;
MemWb_MemRead              = 1'b0           ;


#10


IdEx_Rs                    = 5'b00000       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b00000       ;
MemWb_Rd                   = 5'b11110       ;
ExMem_Rs                   = 5'b00000       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b1           ;
IfId_Rs                    = 5'b11110       ;
IfId_Rt                    = 5'b00000       ;
Ctrl_Branch                = 1'b1           ;
MemWb_MemRead              = 1'b0           ;


#10


IdEx_Rs                    = 5'b00000       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b00101       ;
MemWb_Rd                   = 5'b00000       ;
ExMem_Rs                   = 5'b00000       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b1           ;
IfId_Rs                    = 5'b00101       ;
IfId_Rt                    = 5'b00000       ;
Ctrl_Branch                = 1'b1           ;
MemWb_MemRead              = 1'b0           ;





#10

IdEx_Rs                    = 5'b00000       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b11010       ;
MemWb_Rd                   = 5'b00000       ;
ExMem_Rs                   = 5'b00000       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b1           ;
MemWb_Reg_Wr_Control       = 1'b1           ;
IfId_Rs                    = 5'b11010       ;
IfId_Rt                    = 5'b00000       ;
Ctrl_Branch                = 1'b0           ;
MemWb_MemRead              = 1'b0           ;

#10
IdEx_Rs                    = 5'b11011       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b11011       ;
MemWb_Rd                   = 5'b11110       ;
ExMem_Rs                   = 5'b01110       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b0           ;
MemWb_Reg_Wr_Control       = 1'b0           ;
IfId_Rs                    = 5'b00000       ;
IfId_Rt                    = 5'b11110       ;
Ctrl_Branch                = 1'b1           ;
MemWb_MemRead              = 1'b1           ;

#10

IdEx_Rs                    = 5'b00000       ;
IdEx_Rt                    = 5'b00000       ;
ExMem_Rd                   = 5'b11000       ;
MemWb_Rd                   = 5'b00000       ;
ExMem_Rs                   = 5'b00000       ;
ExMem_Rt                   = 5'b00000       ;
ExMem_Reg_Wr_Control       = 1'b0           ;
MemWb_Reg_Wr_Control       = 1'b1           ;
IfId_Rs                    = 5'b00000       ;
IfId_Rt                    = 5'b11000       ;
Ctrl_Branch                = 1'b1           ;
MemWb_MemRead              = 1'b0           ;


#100
$stop ;
end 

endmodule