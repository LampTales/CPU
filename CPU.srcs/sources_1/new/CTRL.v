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

R-type:
    opcode(6 bits) | rs(5 bits) | rt(5 bits) | rd(5 bits) | shamt(5 bits) | funct(6 bits)
I-type:
    opcode(6 bits) | rs(5 bits) | rt(5 bits) | immediate(16 bits)
J-type:
    opcode(6 bits) | address(26 bits)

    
control signals:
    reg_dst:
        asserted: register destination is rd
        deasserted: register destination is rt
    branch:
        asserted: current instruction is beq
        deasserted: others
    nbranch:
        asserted: current instruction is bne
        deasserted: others
    mem_read:
        asserted: lw
        deasserted: others
    mem_write:
        asserted: sw
        deasserted: others
    mem_to_reg:
        asserted: The value to be written to the register comes from the memory
        deasserted: The value to be written to the register comes from the ALU
    alu_src
    reg_write
    ignore
    simd
    j
    jr
    jal
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
    output jal
    );
    
    always @(*) begin
        
    end


endmodule
