`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 01:19:48
// Design Name: 
// Module Name: PC
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

// unfinish

module PC(
    input clk,
    input rst,
    input [31:0] next,
    output [31:0] out
    );
    reg [31:0] pc;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            pc <= 0; // should be the start address of the instructions !!!
        end
        else begin
            pc <= next;
        end
        
    end

    assign out = pc;
endmodule
