module HAZ_DET_UNIT(

//inputs///

input        IdEx_MemRead        ,
input        MemWb_MemRead       ,
input        IdEx_MemWrite       ,
input [4:0]  IdExRt              ,
input [4:0]  IdExRs              ,
input [4:0]  IfIdRs              ,
input [4:0]  IfIdRt              ,
input [4:0]  MemWbRd             ,

// Detecting Stall for Branch inputs 
input [4:0]  ExMemRd             ,
input [4:0]  ExMemRs             ,
input [4:0]  MemWbRt             ,
input        FwdPc               ,
input        MemRb_Reg_wr_control,
input        Ctrl_Branch         ,

//outs//

output       Flush             ,
output reg   Stall 
//output  reg     PC_Write		  ,
//output	reg	 	IfId_Write        ,
//output  reg     IdEx_Write

);


always @(*)

	begin
		// detecting a stall based on use of a result from load
		if((IdEx_MemRead && ((IdExRt==IfIdRs) | (IdExRt == IfIdRt))) || ((MemWb_MemRead) &&((IdEx_MemRead | IdEx_MemWrite) &&((IdExRs == MemWbRd) | (IdExRt == MemWbRd))) ))
			begin
			 Stall <= 1'b1;				
			end
			
		else 
		
			begin
			
			Stall <= 1'b0;
			
			end
	end
		//Detcting Stall for Branch Condition 
		
	assign Flush = ((FwdPc) ||                                 // instruction Flush if two registgers Equal and Aranch occur
	(Ctrl_Branch && ((MemWb_MemRead && (((MemWbRt == IdExRs ) | (MemWbRt == IdExRt)) && ((IdExRs == ExMemRd) |(ExMemRd == IdExRt)))) |   // if Load and Arhith instructions before branch 
	((MemWbRt == ExMemRs) | (MemWbRt == ExMemRs)))))? 1'b1 : 1'b0;  // if there is load before Branch
	
	//if (Ctrl_Branch && (MemWb_MemRead && ((((MemWb_Rt == IdEx_Rs ) | (MemWb_Rt == IdEx_Rt)) && ((IdEx_Rs == IdEx_Rd) |(MemWb_Rt == IdEx_Rd))) | ((MemWb_Rt == ExMem_Rs) | (MemWb_Rt == ExMem_Rs))))?
	//	begin
	//	Flush <= 1'b1;
	//	
	//	end 
	//else 
	//		Flush = 1'b0;
	//end

	
	
endmodule