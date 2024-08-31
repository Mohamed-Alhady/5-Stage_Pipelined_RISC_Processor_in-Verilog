module Forward_Unit(

// inputs For Data Hazard Detection and Forward
input [4:0]  IdEx_Rs                                      ,
input [4:0]  IdEx_Rt                                      ,
input [4:0]  ExMem_Rd                                     ,
input [4:0]  MemWb_Rd                                     ,
input [4:0]  ExMem_Rs                                     ,
input [4:0]  ExMem_Rt                                     ,
input        ExMem_Reg_Wr_Control                         ,
input        MemWb_Reg_Wr_Control                         ,
                                                 
//inputs for Branch detection and Forwarding 
input [4:0] IfId_Rs             						  ,
input [4:0] IfId_Rt                                       ,        
input       Ctrl_Branch                                   , 
input       MemWb_MemRead                                 ,
//outputs for Data Hazared Detection and forward                                   
output reg [1:0] FwdRs                                    , 
output reg [1:0] FwdRt                                    ,
// outputs for Branch Detection and Forward
output wire       FwdPc                                   ,                 
output reg  [1:0] Fwd_IfId_Rs, Fwd_IfId_Rt 
);


always @(*)
begin
	// conditions for Data Hazard Detection and Forward 
	if((IdEx_Rs==ExMem_Rd) && (ExMem_Rs !=0) && ExMem_Reg_Wr_Control) // bypassing Rs from Memory Stage to ALU OPeration 
		begin
		FwdRs <= 2'b10;
		
		end 
		
	else if((IdEx_Rs==MemWb_Rd) && (ExMem_Rs !=0) && MemWb_Reg_Wr_Control) // bypassing Rs Writeback Stage to ALU OPeration
		begin
			FwdRs <= 2'b01 ;
		
		end
	
	else 	
		FwdRs <= 2'b0 ;
		
		
	if((IdEx_Rt==ExMem_Rd) & (ExMem_Rt !=0) & ExMem_Reg_Wr_Control )  // bypassing Rt from Memory Stage to ALU OPeration
		begin
			FwdRt <=2'b10 ;
	
		end 
		
	else if((IdEx_Rt==MemWb_Rd) & (ExMem_Rt !=0) & MemWb_Reg_Wr_Control ) // bypassing Rt from WriteBack Stage to ALU OPeration
		begin
			FwdRt <=2'b10 ;
		
		end 
		
	else 
		begin
			FwdRt <=2'b0 ;
		
		end 
	end 
	
// Comparing Two Data Register for Updating the Branch condition 
assign FwdPc = ((IfId_Rs == IfId_Rt) && Ctrl_Branch)? 1'b1 : 1'b0;

//Forward Condition if there are Two R-type condition before Branch by cycle 
always @(*)
begin

	if(Ctrl_Branch&& (MemWb_Reg_Wr_Control &&(IfId_Rs == MemWb_Rd)))
		begin 
		
			Fwd_IfId_Rs <= 2'b01;
		end
		
	else if (Ctrl_Branch&& (MemWb_Reg_Wr_Control && (IfId_Rs==ExMem_Rd)))
		begin 	
		
			Fwd_IfId_Rs <= 2'b10; 
			
		end
		
	else 
	begin Fwd_IfId_Rs <= 2'b00; end
	
	
	
	if(Ctrl_Branch&& ((MemWb_Reg_Wr_Control| MemWb_MemRead)  &&(IfId_Rt == MemWb_Rd)))
		begin Fwd_IfId_Rt <= 2'b01; end
	else if (Ctrl_Branch&& ((MemWb_Reg_Wr_Control | MemWb_MemRead) && (IfId_Rt == ExMem_Rd)))
	begin	Fwd_IfId_Rt <= 2'b10;  end
		
	else 
	begin Fwd_IfId_Rt <= 2'b00; end
	
	
	

end


//assign Fwd_IfId = (Ctrl_Branch && ((MemRb_Reg_wr_control && (((MemWb_Rd == IfId_Rs) |(MemWb_Rd==IdIf_Rt)) && ((ExMem_Rd==IdIf_Rs) | (ExMem_Rd==IdEx_Rt))))))? 1'b1 : 1'b0;
//assign Fwd_load = (IdEx_MemRead &&((IdExRt==IfIdRt) | (IdExRt==IfIdRs)))? 1'b1 :1'b0;

endmodule