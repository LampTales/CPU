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

module ALU(
    input [11:0] alu_op,
    input [4:0] shamt,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out,
    output reg equal,
    output reg overflow
    );
    always @(*) begin
        casex(alu_op) 
            12'b000000000000: out = in0 << shamt; //sll
            12'b000000000010: out = in0 >> shamt; //srl
            12'b000000000100: out = in0 << in1; //sllv
            12'b000000000110: out = in0 >> in1; //srlv
            12'b000000000011: out = $signed(in0) >>> shamt; //sra
            12'b000000000111: out = $signed(in0) >>> in1; //srav
            12'b000000100000: out = in0 + in1; //add
            12'b000000100001: out = in0 + in1; //addu
            12'b000000100010: out = in0 - in1; //sub
            12'b000000100011: out = in0 - in1; //subu
            12'b000000100100: out = in0 & in1; //and
            12'b000000100101: out = in0 | in1; //or
            12'b000000100110: out = in0 ^ in1; //xor
            12'b000000100111: out = ~(in0 | in1); //nor
            12'b000000101010: out = $signed(in0) < $signed(in1); //slt
            12'b000000101011: out = in0 < in1; //sltu

            12'b000100xxxxxx: equal = in0 == in1 ? 32'b1 : 32'b0; //beq
            12'b000101xxxxxx: equal = in0 == in1 ? 32'b1 : 32'b0; //bne

            12'b001000xxxxxx: out = in0 + $signed({16'b0, in1}); //addi
            12'b001001xxxxxx: out = in0 + {16'b0, in1}; //addiu
            12'b001010xxxxxx: out = $signed(in0) < $signed({16'b0, in1}); //slti
            12'b001011xxxxxx: out = in0 < {16'b0, in1}; //sltiu
            12'b001100xxxxxx: out = in0 & {16'b0, in1}; //andi
            12'b001101xxxxxx: out = in0 | {16'b0, in1}; //ori
            12'b001110xxxxxx: out = in0 ^ {16'b0, in1}; //xori
            12'b001111xxxxxx: out = {16'b0, in1}; //lui
        endcase
        
    end

    // always@(*) begin
    //     casex(alu_op) 
    //         12'b000000000000: overflow = 0; //sll
    //         12'b000000000010: overflow = 0; //srl
    //         12'b000000000100: overflow = 0; //sllv
    //         12'b000000000110: overflow = 0; //srlv
    //         12'b000000000011: overflow = 0; //sra
    //         12'b000000000111: out = $signed(in0) >>> in1; //srav
    //         12'b000000100000: out = in0 + in1; //add
    //         12'b000000100001: out = in0 + in1; //addu
    //         12'b000000100010: out = in0 - in1; //sub
    //         12'b000000100011: out = in0 - in1; //subu
    //         12'b000000100100: out = in0 & in1; //and
    //         12'b000000100101: out = in0 | in1; //or
    //         12'b000000100110: out = in0 ^ in1; //xor
    //         12'b000000100111: out = ~(in0 | in1); //nor
    //         12'b000000101010: out = $signed(in0) < $signed(in1); //slt
    //         12'b000000101011: out = in0 < in1; //sltu

    //         12'b000100xxxxxx: equal = in0 == in1 ? 32'b1 : 32'b0; //beq
    //         12'b000101xxxxxx: equal = in0 == in1 ? 32'b1 : 32'b0; //bne

    //         12'b001000xxxxxx: out = in0 + $signed({16'b0, in1}); //addi
    //         12'b001001xxxxxx: out = in0 + {16'b0, in1}; //addiu
    //         12'b001010xxxxxx: out = $signed(in0) < $signed({16'b0, in1}); //slti
    //         12'b001011xxxxxx: out = in0 < {16'b0, in1}; //sltiu
    //         12'b001100xxxxxx: out = in0 & {16'b0, in1}; //andi
    //         12'b001101xxxxxx: out = in0 | {16'b0, in1}; //ori
    //         12'b001110xxxxxx: out = in0 ^ {16'b0, in1}; //xori
    //         12'b001111xxxxxx: out = {16'b0, in1}; //lui
    //     endcase
        
    // end
endmodule
