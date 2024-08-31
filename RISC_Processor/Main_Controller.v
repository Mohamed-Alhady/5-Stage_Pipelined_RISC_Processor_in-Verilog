module MAIN_CONTROL(

input wire [5:0] OPCODE				,
input            CLK   				,


//outputs//

output reg     		RegDst          ,
output reg     		Jump            ,
output reg     		Branch          ,
output reg     		MemRead         ,
output reg     		MemtoReg        ,
output reg  [1:0]   Alu_Op          ,
output reg          MemWrite        ,
output reg          ALU_Src         ,
output reg          RegWrite


);

parameter [5:0] R_type = 6'b0, lw=6'b100011, sw= 101011, 
				beq = 6'b000100, bnq =6'b000101, j = 6'b000010, jal=6'b111001;

reg  regdst, jump, branch, memread, memtoreg, memwrite, alusrc, regwrite;

reg  [1:0] aluop ;

always @(*);
	begin
	case (OpCode)
		
	R_type :
		begin
			regdst      <= 1'b1		;
			regwrite    <= 1'b1		;
			aluop       <= 2'b10    ;
			jump        <= 1'b0     ;
			branch      <= 1'b0     ;
			memread     <= 1'b0     ;
			memtoreg    <= 1'b0     ;
			aluscr      <= 1'b0     ;
			memwrite    <= 1'b0     ;
			
		
		end 
	lw    :
		begin 
		
			regdst      <= 1'b0		;
            regwrite    <= 1'b1		;
            aluop       <= 2'b00    ;
            jump        <= 1'b0     ;
            branch      <= 1'b0     ;
            memread     <= 1'b1     ;
		    memtoreg    <= 1'b1     ;
		    aluscr      <= 1'b1     ;
		    memwrite    <= 1'b0     ;
			
		end 
		
	sw		:
		beign
		
			regdst      <= 1'bx		;
			regwrite    <= 1'0		;
			aluop       <= 2'b00    ;
			jump        <= 1'b0     ;
			branch      <= 1'b0     ;
			memread     <= 1'b0     ;
			memtoreg    <= 1'bx     ;
			aluscr      <= 1'b0     ;
			memwrite    <= 1'b1     ;
		
		end 
	
	beq ,bne   : 
		begin
		
			regdst      <= 1'b0		;
			regwrite    <= 1'b0		;
			aluop       <= 2'b01    ;
			jump        <= 1'b0     ;
			branch      <= 1'b1     ;
			memread     <= 1'b0     ;
			memtoreg    <= 1'b0     ;
			aluscr      <= 1'b0     ;
			memwrite    <= 1'b0     ;
		
		
		end

	j	:
		begin
		
			regdst      <= 1'b1		;
	        regwrite    <= 1'b0		;
	        aluop       <= 2'bxx    ;
	        jump        <= 1'b0     ;
	        branch      <= 1'b1     ;
	        memread     <= 1'b0     ;
	        memtoreg    <= 1'b0     ;
	        aluscr      <= 1'b0     ;
	        memwrite    <= 1'b0     ;
	
	
		
		end
		
	default :
		begin
		
			regdst      <= 1'bx		;
			regwrite    <= 1'b0		;
			aluop       <= 2'bxx    ;
			jump        <= 1'b0     ;
			branch      <= 1'b1     ;
			memread     <= 1'b0     ;
			memtoreg    <= 1'b0     ;
			aluscr      <= 1'bx     ;
			memwrite    <= 1'b0     ;
			
		end 
	
	end

always @(posedge CLK)
	begin
		
		RegDst      <=  regdst      ;
		regwrite    <=  RegWrite    ;
		Alu_Op      <=  aluop       ;
		Jump        <=  jump         ;
		Branch      <=  branch       ;
		MemRead     <=  memread      ;
		MemtoReg    <=  memtoreg     ;
	    MemWrite    <=  memwrite     ;
	    ALU_Src     <=  aluscr       ;
	   
	
	end
	
endmodule