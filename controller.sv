/*Multicycle CPU COntroller Designed according to the ASM chart Provided with the report.
No separate decode module is used. Thus, next state and outputs are determined with if else statements. */



module Controller (
    input clock, input reset, input Z, input C, input [15:0] INST,
    output logic mux_alu_shift, output logic exec_enable, output logic alu_pc_sel, output logic ra_rb_enable, output logic srcA_sel, output logic [2:0] alu_ctr, output logic srcB_mem_reg_sel, output logic regf_WE, output logic Inst_en, output logic mem_buff_en, output logic WD3_src_sel, output logic mem_WE, output logic [1:0] mem_addr_src_sel, output logic PC_WE, output logic [1:0] PC_SRC, output logic LR_EN);

    enum int unsigned { FETCH=0, DECODE_BL_BIL=1, DECODE_ALOP_REGISTER=2, WRITE_BL=3, MEM_READ_IND_ALOP=4, EXECUTE_ALOP_REGISTER=5, WRITEBACK_ALOP=6, WRITE_BIL=7, WRITE_B=8, DECODE_MEM=9, WRITE_TO_MEM=10, DECODE=11, WRITE_BLR = 12 } fstate, reg_fstate;

	 logic [1:0] flags ; // In ZC order
	 
    always_ff @(posedge clock)
    begin
        if (clock) 
            fstate  = reg_fstate;
	 end
	 
	 always_ff @(negedge clock)
    begin
			if ((fstate == EXECUTE_ALOP_REGISTER)&(INST[15:14] == 2'b00 )) // only Arithmetic and logic operations alter the flags
	   	     flags[1:0] <= {Z,C} ;
	 end
	 

	 
    always_comb begin
        if (reset) begin			//Set to default all control signals when reseted
            reg_fstate  <= FETCH;
            mux_alu_shift  = 1'b0;
            exec_enable  = 1'b0;
            alu_pc_sel  = 1'b0;
            ra_rb_enable  = 1'b0;
            srcA_sel  = 1'b0;
            alu_ctr  = 3'b000;
            srcB_mem_reg_sel  = 1'b0;
            regf_WE  = 1'b0;
            Inst_en  = 1'b0;
            mem_buff_en  = 1'b0;
            WD3_src_sel  = 1'b0;
            mem_WE  = 1'b0;
            mem_addr_src_sel  = 2'b00;
            PC_WE  = 1'b0;
            PC_SRC  = 2'b00;
            LR_EN  = 1'b0;
        end
        else begin					
            mux_alu_shift  = 1'b0;
            exec_enable  = 1'b0;
            alu_pc_sel  = 1'b0;
            ra_rb_enable  = 1'b0;
            srcA_sel  = 1'b0;
            alu_ctr  = 3'b000;
            srcB_mem_reg_sel  = 1'b0;
            regf_WE  = 1'b0;
            Inst_en  = 1'b0;
            mem_buff_en  = 1'b0;
            WD3_src_sel  = 1'b0;
            mem_WE  = 1'b0;
            mem_addr_src_sel  = 2'b00;
            PC_WE  = 1'b0;
            PC_SRC  = 2'b00;
            LR_EN  = 1'b0;
            case (fstate)
                FETCH: begin   //In fetch state, read the memory using PC. Then go to DECODE
						  reg_fstate  <= DECODE;
							
                    mem_addr_src_sel  = 2'b00;

                    Inst_en  = 1'b1;

                    alu_ctr  = 3'b000;

                    srcA_sel  = 1'b0;

                    alu_pc_sel  = 1'b1;
						  
						  PC_WE  = 1'b1;
                end
					 DECODE:begin  //IN DECODE stage, choose the next state by using instroction fields, this state is a kind of a delay state and to choose the next state.
					     if ((INST[15:13] == 3'b011))
                        reg_fstate  <= DECODE_BL_BIL;
                    else if ((INST[15:14] == 2'b00)|(INST[15:13] == 3'b010))
                        reg_fstate  <= DECODE_ALOP_REGISTER;
                    else if ((INST[15:13] == 3'b100))
                        reg_fstate  <= DECODE_MEM;
                    else
                        reg_fstate  <= FETCH;
					     
					 end
                DECODE_BL_BIL: begin //If an instruction is a branch instruction, this state is choosen, PC+1 is not written to PC
                    if ((INST[12:10] == 3'b001))
                        reg_fstate  <= WRITE_BL;
                    else if ((INST[12:10] == 3'b000)|(INST[12:10] == 3'b011)|(INST[12:10] == 3'b100)|(INST[12:10] == 3'b101)|(INST[12:10] == 3'b110))
                        reg_fstate  <= WRITE_B;
                    else if ((INST[12:10] == 3'b010))
                        reg_fstate  <= MEM_READ_IND_ALOP;
						  else if (INST[12:10] == 3'b111)
								reg_fstate  <= WRITE_BLR;
                    else
                        reg_fstate  <= DECODE_BL_BIL;

                    PC_WE  = 1'b0;
                end
                DECODE_ALOP_REGISTER: begin  // ALOP(Arithmetic Logic Operations) In this state, If the instruction is indirect, an extra memory read is made, otherwise, the next stage is execute
                    if (((INST[15:10] == 6'b000001) | (INST[15:10] == 6'b000011)))
                        reg_fstate  <= MEM_READ_IND_ALOP;
                    else if ((~(((INST[15:10] == 6'b000001) | (INST[15:10] == 6'b000011))))|(INST[15:13] == 3'b010))
                        reg_fstate  <= EXECUTE_ALOP_REGISTER;
                    else
                        reg_fstate  <= DECODE_ALOP_REGISTER;

                    PC_WE  = 1'b0;

                    ra_rb_enable  = 1'b1;
                end
                WRITE_BL: begin					// In this state link register is written with PC
                    reg_fstate  <= FETCH;

                    LR_EN  = 1'b1;

                    PC_SRC  = 2'b10;

                    PC_WE  = 1'b1;
                end
                MEM_READ_IND_ALOP: begin   // In this state a memory read is made according to the operaitons
                    if ((INST[15:10] == 6'b011010)) begin
                        reg_fstate  <= WRITE_BIL;  //Read Label Address
						      mem_addr_src_sel  = 2'b11;
								mem_buff_en  = 1'b1;
						  end
                    else if (((((INST[15:13] == 3'b000) | (INST[15:13] == 3'b001)) | (INST[15:13] == 3'b010)))) begin
                        reg_fstate  <= EXECUTE_ALOP_REGISTER; //Read indirect Data from the memory
						      mem_addr_src_sel  = 2'b11;
								mem_buff_en  = 1'b1;
                    end
						  else if ((INST[15:10] == 6'b100000)) begin
                        reg_fstate  <= EXECUTE_ALOP_REGISTER; //Read LDR data
						      mem_addr_src_sel  = 2'b01;
								mem_buff_en  = 1'b1;
						  end
						  else begin
                        reg_fstate  <= MEM_READ_IND_ALOP;
						      mem_addr_src_sel  = 2'b11; 
								mem_buff_en  = 1'b1;
						  end

                end
                EXECUTE_ALOP_REGISTER: begin  //In this state, alu control and input multiplexers are controlled according to the instructions
                    reg_fstate  <= WRITEBACK_ALOP;
						  
						  
                    if (~(((INST[15:10] == 6'b000001) | (INST[15:10] == 6'b000011)|(INST[15:10] == 6'b100000))))
                        srcB_mem_reg_sel  = 1'b1;
                    else if (((INST[15:10] == 6'b000001) | (INST[15:10] == 6'b000011)|(INST[15:10] == 6'b100000)))
                        srcB_mem_reg_sel  = 1'b0;
                 
                    else
                        srcB_mem_reg_sel  = 1'b0;

                    if (((INST[15:10] == 6'b000000) | (INST[15:10] == 6'b000001)))
                        alu_ctr  = 3'b000;
                    else if (((INST[15:10] == 6'b000010) | (INST[15:10] == 6'b000011)))
                        alu_ctr  = 3'b001;
                    else if ((INST[15:10] == 6'b001000))
                        alu_ctr  = 3'b010;
                    else if ((INST[15:10] == 6'b001001))
                        alu_ctr  = 3'b011;
                    else if ((INST[15:10] == 6'b001010))
                        alu_ctr  = 3'b100;
                    else if ((INST[15:10] == 6'b001011))
                        alu_ctr  = 3'b101;
                    else if ((INST[15:10] == 6'b100000))
                        alu_ctr  = 3'b110;
                    
                    else
                        alu_ctr  = 3'b000;

                    srcA_sel  = 1'b1;

                    alu_pc_sel  = 1'b0;

                    exec_enable  = 1'b1;

                    if ((INST[15:13] == 3'b010))
                        mux_alu_shift  = 1'b1;
                 
                    else
                        mux_alu_shift  = 1'b0;
                end
                WRITEBACK_ALOP: begin  //In this state, alu operations are written to register file
                    reg_fstate  <= FETCH;

                    if ((INST[15] == 1'b0)|(INST[15:10] == 6'b100000))
                        WD3_src_sel  = 1'b1;
                   
                    else
                        WD3_src_sel  = 1'b0;

                    regf_WE  = 1'b1;
                end
                WRITE_BIL: begin //In this state link register and PC is written
                    reg_fstate  <= FETCH;

                    LR_EN  = 1'b1;

                    PC_SRC  = 2'b11;

                    PC_WE  = 1'b1;
                end
                WRITE_B: begin //In this state, only PC is written
                    reg_fstate  <= FETCH;

                    PC_SRC  = 2'b10;

                    if (((((((INST[12:10] == 3'b000) | ((INST[12:10] == 3'b011) & (flags[1] == 1'b1))) | ((INST[12:10] == 3'b100) & (flags[1] == 1'b0))) | ((INST[12:10] == 3'b101) & (flags[0] == 1'b1))) | ((INST[12:10] == 3'b110) & (flags[0] == 1'b0))))& (INST[15:13] == 3'b011))
                        PC_WE  = 1'b1;
                   
                    else
                        PC_WE  = 1'b0;
                end
                DECODE_MEM: begin // In this state memory operations are decoded
                    if ((INST[15:10] == 6'b100000))
                        reg_fstate  <= MEM_READ_IND_ALOP;
                    else if ((INST[15:10] == 6'b100010))
                        reg_fstate  <= WRITE_TO_MEM;
                    else if ((INST[15:10] == 6'b100001))
                        reg_fstate  <= WRITEBACK_ALOP;
                  
                    else
                        reg_fstate  <= DECODE_MEM;

                    PC_WE  = 1'b0;

                    ra_rb_enable  = 1'b1;
                end
                WRITE_TO_MEM: begin //In this state memory is written
                    reg_fstate  <= FETCH;

                    mem_addr_src_sel  = 2'b11;

                    mem_WE  = 1'b1;
                end
					 WRITE_BLR: begin // In this state PC is loaded with Link Register, thus it is branch to link register
						  reg_fstate  <= FETCH;
                    PC_SRC  = 2'b01;
                    PC_WE  = 1'b1;
					 end
                default: begin
                    mux_alu_shift  = 1'bx;
                    exec_enable  = 1'bx;
                    alu_pc_sel  = 1'bx;
                    ra_rb_enable  = 1'bx;
                    srcA_sel  = 1'bx;
                    alu_ctr  = 3'bxxx;
                    srcB_mem_reg_sel  = 1'bx;
                    regf_WE  = 1'bx;
                    Inst_en  = 1'bx;
                    mem_buff_en  = 1'bx;
                    WD3_src_sel  = 1'bx;
                    mem_WE  = 1'bx;
                    mem_addr_src_sel  = 2'bxx;
                    PC_WE  = 1'bx;
                    PC_SRC  = 2'bxx;
                    LR_EN  = 1'bx;
                    $display ("Reach undefined state");
                end
            endcase
        end
    end
endmodule
