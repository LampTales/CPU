`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:25:32
// Design Name: 
// Module Name: REG
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


module REG(
    input clk,
    input rst,
    input [4:0] read0,
    input [4:0] read1,
    input [4:0] write,
    input [31:0] write_data,
    input [127:0] simd_write_data,
    input reg_write,
    input simd,
    output [31:0] read_data0,
    output [31:0] read_data1,
    output [127:0] simd_read_data0,
    output [127:0] simd_read_data1,
    input div
    );
endmodule
