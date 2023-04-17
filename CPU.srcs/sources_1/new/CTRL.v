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
endmodule
