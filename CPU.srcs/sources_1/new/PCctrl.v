`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 17:46:15
// Design Name: 
// Module Name: PCctrl
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


module PCctrl(
    input [31:0] pc,
    input j,
    input jal,
    input [25:0] j_inst,
    input branch,
    input nbranch,
    input equal,
    input [31:0] expand_imme,
    input jr,
    input [31:0] ra,
    output [31:0] link_addr,
    output [31:0] next
    );
endmodule
