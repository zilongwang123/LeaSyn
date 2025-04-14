`define TYPE_R 3'd0
`define TYPE_I 3'd1
`define TYPE_S 3'd2
`define TYPE_B 3'd3
`define TYPE_U 3'd4
`define TYPE_J 3'd5
`define TYPE_ERR 3'd6

`define LUI_OP		7'b0110111
`define AUIPC_OP 	7'b0010111
`define JAL_OP		7'b1101111
`define JALR_OP		7'b1100111
`define BEQ_OP		7'b1100011
`define BNE_OP		7'b1100011
`define BLT_OP		7'b1100011
`define BGE_OP		7'b1100011
`define BLTU_OP		7'b1100011
`define BGEU_OP		7'b1100011
`define LB_OP		7'b0000011
`define LH_OP		7'b0000011
`define LW_OP		7'b0000011
`define LBU_OP		7'b0000011
`define LHU_OP		7'b0000011
`define SB_OP		7'b0100011
`define SH_OP		7'b0100011
`define SW_OP		7'b0100011
`define ADDI_OP		7'b0010011
`define SLTI_OP		7'b0010011
`define SLTIU_OP	7'b0010011
`define XORI_OP		7'b0010011
`define ORI_OP		7'b0010011
`define ANDI_OP		7'b0010011
`define SLLI_OP		7'b0010011
`define SRLI_OP		7'b0010011
`define SRAI_OP		7'b0010011
`define ADD_OP		7'b0110011
`define SUB_OP		7'b0110011
`define SLL_OP		7'b0110011
`define SLT_OP		7'b0110011
`define SLTU_OP		7'b0110011
`define XOR_OP		7'b0110011
`define SRL_OP		7'b0110011
`define SRA_OP		7'b0110011
`define OR_OP		7'b0110011
`define AND_OP		7'b0110011

module riscv_validator (
    input logic [31:0] instr_i,
    output logic valid_o,
);


    logic [2:0] format;
    logic [6:0] op;
    logic [2:0] funct_3;
    logic [6:0] funct_7;
    logic [4:0] rd;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [31:0] imm;
    
    assign op = instr_i[6:0];
    assign funct_3 = instr_i[14:12];
    assign funct_7 = instr_i[31:25];
    assign format = (
                            op == `ADD_OP
                        ) ? `TYPE_R : 
                        (
                            (
                                op == `SLLI_OP ||
                                op == `JALR_OP ||
                                op == `LB_OP
                            ) ? `TYPE_I :
                            (
                                (
                                    op == `SB_OP
                                ) ? `TYPE_S :
                                (
                                    (
                                        op == `BEQ_OP
                                    ) ? `TYPE_B :
                                    (
                                        op == `LUI_OP ||
                                        op == `AUIPC_OP
                                    ) ? `TYPE_U :
                                    (
                                        (
                                            op == `JAL_OP
                                        ) ? `TYPE_J : `TYPE_ERR
                                    )
                                )
                            )
                        );
    assign rd = instr_i[11:7];
    assign rs1 = instr_i[19:15];
    assign rs2 = instr_i[24:20];
    assign imm =  (
                        (format == `TYPE_R) ? 32'b0 :
                        (
                            (format == `TYPE_I) ? {20'b0, instr_i[31:20]} :
                            (
                                (format == `TYPE_S) ? {20'b0, instr_i[31:25], instr_i[11:7]} :
                                (
                                    (format == `TYPE_B) ? {19'b0, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:6], 1'b0} :
                                    (
                                        (format == `TYPE_U) ? {instr_i[31:12], 12'b0} :
                                        (
                                            (format == `TYPE_J) ? {12'b0, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0} :
                                            32'b0
                                        )
                                    )
                                )
                            )
                        )
                    );

    logic valid_u_type;
    assign valid_u_type = (op == `LUI_OP || op == `AUIPC_OP) ? 1'b1 : 1'b0;

    logic valid_j_type;
    assign valid_j_type = (op == `JAL_OP) ? 1'b1 : 1'b0;

    logic valid_i_type;

        logic valid_load;
        assign valid_load = ((op == `LB_OP) && (funct_3 == 3'b000 || funct_3 == 3'b001 || funct_3 == 3'b010 || funct_3 == 3'b100 || funct_3 == 3'b101)) ? 1'b1 : 1'b0;
        logic valid_shift;
        assign valid_shift = ((op == `SLLI_OP) && (funct_3 == 3'b001 || funct_3 == 3'b101) && (funct_7 == 7'b0000000)) || ((op == `SRAI_OP) && (funct_3 == 3'b101) && (funct_7 == 7'b0100000)) ? 1'b1 : 1'b0;
        logic valid_xxxi;
        assign valid_xxxi = ((op == `ADDI_OP) && (funct_3 == 3'b000 || funct_3 == 3'b010 || funct_3 == 3'b011 || funct_3 == 3'b100 || funct_3 == 3'b110 || funct_3 == 3'b111)) ? 1'b1 : 1'b0;
        logic valid_jalr;
        assign valid_jalr = ((op == `JALR_OP) && (funct_3 == 3'b000)) ? 1'b1 : 1'b0;

    assign valid_i_type = valid_load || valid_shift || valid_xxxi || valid_jalr;

    logic valid_r_type;
    
        logic valid_pos;
        assign valid_pos = ((op == `ADD_OP) && (funct_7 == 7'b0000000)) ? 1'b1 : 1'b0;
        logic valid_neg;
        assign valid_neg = ((op == `SUB_OP) && (funct_3 == 3'b000 || funct_3 == 3'b101) && (funct_7 == 7'b0100000)) ? 1'b1 : 1'b0;
        logic valid_mul;
        assign valid_mul = ((op == `ADD_OP) && (funct_7 == 7'b0000001)) ? 1'b1 : 1'b0;

    assign valid_r_type = valid_pos || valid_neg || valid_mul;

    logic valid_s_type;
    assign valid_s_type = ((op == `SB_OP) && (funct_3 == 3'b000 || funct_3 == 3'b001 || funct_3 == 3'b010)) ? 1'b1 : 1'b0;

    logic valid_b_type;
    assign valid_b_type = ((op == `BEQ_OP) && (funct_3 == 3'b000 || funct_3 == 3'b001 || funct_3 == 3'b100 || funct_3 == 3'b101 || funct_3 == 3'b110 || funct_3 == 3'b111)) ? 1'b1 : 1'b0;

    assign valid_o = valid_u_type || valid_j_type || valid_i_type || valid_r_type || valid_s_type || valid_b_type;
endmodule