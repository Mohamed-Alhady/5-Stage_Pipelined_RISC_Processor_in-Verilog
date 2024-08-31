module HAZ_DET_UNIT_TB();

reg        IdEx_MemRead        ;
reg        MemWb_MemRead       ;
reg        IdEx_MemWrite       ;
reg [4:0]  IdExRt              ;
reg [4:0]  IdExRs              ;
reg [4:0]  IfIdRs              ;
reg [4:0]  IfIdRt              ;
reg [4:0]  MemWbRd             ;
reg [4:0]  ExMemRd             ;
reg [4:0]  ExMemRs             ;
reg [4:0]  MemWbRt             ;
reg        FwdPc               ;
reg        MemRb_Reg_wr_control;
reg        Ctrl_Branch         ;


wire       Flush                ;
wire       Stall                ;



HAZ_DET_UNIT U6(

.IdEx_MemRead            (IdEx_MemRead 		    ) ,          
.MemWb_MemRead           (MemWb_MemRead		    ) ,
.IdEx_MemWrite           (IdEx_MemWrite		    ) ,
.IdExRt                  (IdExRt       		    ) ,
.IdExRs                  (IdExRs       		    ) ,
.IfIdRs                  (IfIdRs       		    ) ,
.IfIdRt                  (IfIdRt       		    ) ,
.MemWbRd                 (MemWbRd      		    ) ,
.ExMemRd                 (ExMemRd      		    ) ,
.MemWbRt                 (MemWbRt               ) ,
.ExMemRs                 (ExMemRs               ) ,
.FwdPc                   (FwdPc                 ) ,
.MemRb_Reg_wr_control    (MemRb_Reg_wr_control  ) ,
.Ctrl_Branch             (Ctrl_Branch           ) ,
.Flush                   (Flush 				) ,
.Stall                   (Stall 				)                 

);




initial begin

$dumpfile("HAZ_DET_UNIT.vcd");
$dumpvars();

IdEx_MemRead            <=  1'b1            ;
MemWb_MemRead           <=  1'b0            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b01011        ;
IdExRs                  <=  5'b00000        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b01011        ;
MemWbRd                 <=  5'b00000        ;
MemWbRt                 <=  5'b00000        ;
ExMemRs                 <=  5'b00000        ;
ExMemRd                 <=  5'b00000        ;
FwdPc                   <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

#10

IdEx_MemRead            <=  1'b1            ;
MemWb_MemRead           <=  1'b1            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b00000        ;
IdExRs                  <=  5'b11010        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b00000        ;
MemWbRd                 <=  5'b11010        ;
MemWbRt                 <=  5'b00000        ;
FwdPc                   <=  5'b00000        ;
ExMemRd                 <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

#10

IdEx_MemRead            <=  1'b0            ;
MemWb_MemRead           <=  1'b1            ;
IdEx_MemWrite           <=  1'b1            ;
IdExRt                  <=  5'b00110        ;
IdExRs                  <=  5'b00000        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b00000        ;
MemWbRd                 <=  5'b00110        ;
MemWbRt                 <=  5'b00000        ;
FwdPc                   <=  5'b00000        ;
ExMemRd                 <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

// states For Fush
#10

IdEx_MemRead            <=  1'b0            ;
MemWb_MemRead           <=  1'b0            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b00000        ;
IdExRs                  <=  5'b00000        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b00000        ;
MemWbRd                 <=  5'b00000        ;
MemWbRt                 <=  5'b00000        ;
ExMemRd                 <=  5'b00000        ;
FwdPc                   <=  1'b1            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

#10 

IdEx_MemRead            <=  1'b0            ;
MemWb_MemRead           <=  1'b1            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b11101        ;
IdExRs                  <=  5'b01111        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b00000        ;
MemWbRd                 <=  5'b00000        ;
MemWbRt                 <=  5'b01111        ;
ExMemRd                 <=  5'b11101        ;
FwdPc                   <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b1            ;

#10

IdEx_MemRead            <=  1'b1            ;
MemWb_MemRead           <=  1'b0            ;
IdEx_MemWrite           <=  1'b1            ;
IdExRt                  <=  5'b00000        ;
IdExRs                  <=  5'b11111        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b00000        ;
MemWbRd                 <=  5'b11111        ;
MemWbRt                 <=  5'b00000        ;
ExMemRd                 <=  5'b00000        ;
FwdPc                   <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

#10

IdEx_MemRead            <=  1'b0            ;
MemWb_MemRead           <=  1'b0            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b01011        ;
IdExRs                  <=  5'b00000        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b01011        ;
MemWbRd                 <=  5'b00000        ;
MemWbRt                 <=  5'b10011        ;
ExMemRs                 <=  5'b10011        ;
ExMemRd                 <=  5'b00000        ;
FwdPc                   <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b1            ;

#10

IdEx_MemRead            <=  1'b0            ;
MemWb_MemRead           <=  1'b0            ;
IdEx_MemWrite           <=  1'b0            ;
IdExRt                  <=  5'b01011        ;
IdExRs                  <=  5'b00000        ;
IfIdRs                  <=  5'b00000        ;
IfIdRt                  <=  5'b01011        ;
MemWbRd                 <=  5'b00000        ;
MemWbRt                 <=  5'b10011        ;
ExMemRs                 <=  5'b10011        ;
ExMemRd                 <=  5'b00000        ;
FwdPc                   <=  1'b0            ;
MemRb_Reg_wr_control    <=  1'b0            ;
Ctrl_Branch             <=  1'b0            ;

#100
$stop;

end  

endmodule












