`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:15:02
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



/*
    | name | opcode(6 bits) | funct(6 bits)   
R-type:
      sll    000000          000000
      srl    000000          000010
      sllv   000000          000100
      srlv   000000          000110
      sra    000000          000011
      srav   000000          000111
      mult   000000          011000
      div    000000          011010
      add    000000          100000
      addu   000000          100001
      sub    000000          100010
      subu   000000          100011
      and    000000          100100
      or     000000          100101
      xor    000000          100110
      nor    000000          100111
      slt    000000          101010
      sltu   000000          101011
I-type:
      beq    000100          xxxxxx
      bne    000101          xxxxxx
      addi   001000          xxxxxx
      addiu  001001          xxxxxx
      slti   001010          xxxxxx
      sltiu  001011          xxxxxx
      andi   001100          xxxxxx
      ori    001101          xxxxxx
      xori   001110          xxxxxx
      lui    001111          xxxxxx

*/


//TODO lw & sw



module ALU(
    input [11:0] alu_op,
    input [4:0] shamt,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out,
    output reg equal,
    output reg [7:0] errorcode
    );

    // R-type
    localparam [11:0] SLL = 12'b000000000000;
    localparam [11:0] SRL = 12'b000000000010;
    localparam [11:0] SLLV = 12'b000000000100;
    localparam [11:0] SRLV = 12'b000000000110;
    localparam [11:0] SRA = 12'b000000000011;
    localparam [11:0] SRAV = 12'b000000000111;
    localparam [11:0] MULT = 12'b000000011000;
    localparam [11:0] DIV = 12'b000000011010;
    localparam [11:0] ADD = 12'b000000100000;
    localparam [11:0] ADDU = 12'b000000100001;
    localparam [11:0] SUB = 12'b000000100010;
    localparam [11:0] SUBU = 12'b000000100011;
    localparam [11:0] AND = 12'b000000100100;
    localparam [11:0] OR = 12'b000000100101;
    localparam [11:0] XOR = 12'b000000100110;
    localparam [11:0] NOR = 12'b000000100111;
    localparam [11:0] SLT = 12'b000000101010;
    localparam [11:0] SLTU = 12'b000000101011;

    // I-type
    localparam [11:0] BEQ = 12'b000100xxxxxx;
    localparam [11:0] BNE = 12'b000101xxxxxx;
    localparam [11:0] ADDI = 12'b001000xxxxxx;
    localparam [11:0] ADDIU = 12'b001001xxxxxx;
    localparam [11:0] SLTI = 12'b001010xxxxxx;
    localparam [11:0] SLTIU = 12'b001011xxxxxx;
    localparam [11:0] ANDI = 12'b001100xxxxxx;
    localparam [11:0] ORI = 12'b001101xxxxxx;
    localparam [11:0] XORI = 12'b001110xxxxxx;
    localparam [11:0] LUI = 12'b001111xxxxxx;


    always @(*) begin
        casex(alu_op)

            SLL: begin 
                out = in0 << shamt; 
                equal = 0;
                errorcode = 8'b00;
            end//sll

            SRL: begin 
                out = in0 >> shamt; 
                equal = 0;
                errorcode = 8'b00;
            end//srl

            SLLV: begin 
                out = in0 << in1; 
                equal = 0;
                errorcode = 8'b00;
            end//sllv

            SRLV: begin 
                out = in0 >> in1; 
                equal = 0;
                errorcode = 8'b00;
            end//srlv

            SRA: begin 
                out = $signed(in0) >>> shamt; 
                equal = 0;
                errorcode = 8'b00;
            end//sra

            SRAV: begin 
                out = $signed(in0) >>> in1; 
                equal = 0;
                errorcode = 8'b00;
            end//srav

            MULT: begin 
                out = in0 * in1; 
                equal = 0;
                errorcode = 8'b00;
            end//mult

            DIV: begin 
                if (in1 == 0) begin 
                    out = 32'b0; 
                    equal = 0;
                    errorcode = 8'b10; 
                end
                else begin 
                    out[31:16] = in0 / in1; 
                    out[15:0] = in0 % in1; 
                equal = 0;
                    errorcode = 8'b00; 
                end
            end//div

            ADD: begin 
                out = in0 + in1; 
                equal = 0;
                errorcode = (in0[31] == in1[31] && out[31] != in0[31]) ? 8'b01 : 8'b00; 
            end//add

            ADDU: begin 
                out = in0 + in1; 
                equal = 0;
                errorcode = 8'b00;
            end//addu

            SUB: begin 
                out = in0 - in1; 
                equal = 0;
                errorcode = (in0[31] != in1[31] && out[31] != in0[31]) ? 8'b01 : 8'b00; 
            end//sub

            SUBU: begin 
                out = in0 - in1; 
                equal = 0;
                errorcode = 8'b00;
            end//subu

            AND: begin 
                out = in0 & in1; 
                equal = 0;
                errorcode = 8'b00;
            end//and

            OR: begin 
                out = in0 | in1; 
                equal = 0;
                errorcode = 8'b00;
            end//or

            XOR: begin 
                out = in0 ^ in1; 
                equal = 0;
                errorcode = 8'b00;
            end//xor

            NOR: begin 
                out = ~(in0 | in1); 
                equal = 0;
                errorcode = 8'b00;
            end//nor

            SLT: begin 
                out = $signed(in0) < $signed(in1); 
                equal = 0;
                errorcode = 8'b00;
            end//slt

            SLTU: begin 
                out = in0 < in1; 
                equal = 0;
                errorcode = 8'b00;
            end//sltu

            BEQ: begin 
                out = 0;
                equal = in0 == in1 ? 32'b1 : 32'b0; 
                errorcode = 8'b00;
            end//beq

            BNE: begin 
                out = 0;
                equal = in0 == in1 ? 32'b1 : 32'b0; 
                errorcode = 8'b00;
            end//bne

            ADDI: begin 
                out = in0 + in1; 
                equal = 0;
                errorcode = (in0[31] == in1[31] && out[31] != in0[31]) ? 8'b01 : 8'b00; 
            end//addi

            ADDIU: begin 
                out = in0 + in1; 
                equal = 0;
                errorcode = 8'b00;
            end//addiu

            SLTI: begin 
                out = in0 < in1; 
                equal = 0;
                errorcode = 8'b00;
            end//slti

            SLTIU: begin 
                out = in0 < in1; 
                equal = 0;
                errorcode = 8'b00;
            end//sltiu

            ANDI: begin 
                out = in0 & in1; 
                equal = 0;
                errorcode = 8'b00;
            end//andi

            ORI: begin 
                out = in0 | in1; 
                equal = 0;
                errorcode = 8'b00;
            end//ori

            XORI: begin 
                out = in0 ^ in1; 
                equal = 0;
                errorcode = 8'b00;
            end//xori

            LUI: begin 
                out = {in1[15:0], 16'b0}; 
                equal = 0;
                errorcode = 8'b00;
            end//lui

            default: begin 
                out = 32'b0; 
                equal = 0;
                errorcode = 8'b0; 
            end

        endcase
    end

endmodule
