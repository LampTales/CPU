`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:18:58
// Design Name: 
// Module Name: Expander
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

// build finish
// test waiting

module Expander(
    input [15:0] imme,
    input ignore,
    output [31:0] expand_imme
    );
    wire [31:0] non_ignore;
    reg [15:0] zero = 0;
    assign non_ignore = {16 * imme[15], imme[15:0]};
    assign expand_imme = ignore ? {zero[15:0], imme[15:0]} : non_ignore;
endmodule
