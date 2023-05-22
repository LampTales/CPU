`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:26:07
// Design Name: 
// Module Name: CTRL
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
      jr     000000          001000
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
      lw     100011          xxxxxx
      sw     101011          xxxxxx
      addi   001000          xxxxxx
      addiu  001001          xxxxxx
      slti   001010          xxxxxx
      sltiu  001011          xxxxxx
      andi   001100          xxxxxx
      ori    001101          xxxxxx
      xori   001110          xxxxxx
      lui    001111          xxxxxx
J-type:
      j      000010          xxxxxx
      jal    000011          xxxxxx  

// special:
SIMD-type:
      adds   000000          001011
      subs   000000          001010
CPU-ctrl:
      eret   010000          xxxxxx
R-type:
    opcode(6 bits) | rs(5 bits) | rt(5 bits) | rd(5 bits) | shamt(5 bits) | funct(6 bits)
I-type:
    opcode(6 bits) | rs(5 bits) | rt(5 bits) | immediate(16 bits)
J-type:
    opcode(6 bits) | address(26 bits)

*/


module CTRL(
    input [5:0] op_code,
    input [4:0] shamt_in,
    input [5:0] func_code,
    output [11:0] alu_op,
    output [4:0] shamt_out,
    output reg_dst,
    output branch,
    output nbranch,
    output mem_read,
    output mem_write,
    output mem_to_reg,
    output alu_src,
    output reg_write,
    output ignore,
    output simd,
    output j,
    output jr,
    output jal,
    output eret
    );


    assign alu_op[11:0] = {op_code[5:0], func_code[5:0]};

    assign shamt_out = shamt_in;

/*
control signals:
    ignore
    simd
*/
/*
    reg_dst:
        asserted: register destination is rd
        deasserted: register destination is rt
*/
    assign reg_dst = (op_code == 6'b000000) ? 1'b1 : 1'b0;
/*
    branch:
        asserted: current instruction is beq
        deasserted: others
*/
    assign branch = (op_code == 6'b000100) ? 1'b1 : 1'b0;
/*
    nbranch:
        asserted: current instruction is bne
        deasserted: others
*/
    assign nbranch = (op_code == 6'b000101) ? 1'b1 : 1'b0;
/*
    mem_read:
        asserted: lw
        deasserted: others
*/
    assign mem_read = (op_code == 6'b100011) ? 1'b1 : 1'b0;
/*
    mem_write:
        asserted: sw
        deasserted: others
*/
    assign mem_write = (op_code == 6'b101011) ? 1'b1 : 1'b0;
/*
    mem_to_reg:
        asserted: The value to be written to the register comes from the memory
        deasserted: The value to be written to the register comes from the ALU
    others: 0
    lw: 1
*/
    assign mem_to_reg = (op_code == 6'b100011) ? 1'b1 : 1'b0;
/*
    alu_src:
        asserted: The second ALU operand comes from the sign-extended, lower 16 bits of the instruction
        deasserted: The second ALU operand comes from the second register file output
    others: 0
    lw, sw: 1
*/
    assign alu_src = (op_code == 6'b100011 || op_code == 6'b101011) ? 1'b1 : 1'b0;

/*
    reg_write:
        asserted: The register on the Write register input is written with the value 
                    on the Write data input
        deasserted: The register on the Write register input is not written
    sw, beq, bne: 0
    others: 1
*/
    assign reg_write = (op_code == 6'b100011 || op_code == 6'b000100 || op_code == 6'b000101) ? 1'b1 : 1'b0;

/*
    j:
        asserted: j
        deasserted: others
*/
    assign j = (op_code == 6'b000010) ? 1'b1 : 1'b0;

/*
    jr:
        asserted: jr
        deasserted: others
*/
    assign jr = (op_code == 6'b000000 && func_code == 6'b001000) ? 1'b1 : 1'b0;
/*
    jal:
        asserted: jal
        deasserted: others
*/
    assign jal = (op_code == 6'b000011) ? 1'b1 : 1'b0;


    // aditional ports by oyl
    assign ignore = (op_code == 6'b001100 || op_code == 6'b001101 || op_code == 6'b001110) ? 1'b1 : 1'b0;

    assign simd = (op_code == 6'b000000 && (func_code == 6'b001011 || func_code == 6'b001010)) ? 1'b1 : 1'b0;

    // ICU return from wyr
    assign eret = (op_code ==6'b010000) ? 1'b1 : 1'b0;
endmodule
