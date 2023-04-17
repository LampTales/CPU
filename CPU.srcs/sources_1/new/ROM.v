`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 00:30:02
// Design Name: 
// Module Name: ROM
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


module ROM(
    input clk,
    input rst,
    input [31:0] addr,
    output [31:0] instruction
    );

    rom_ip inner_rom(
        .addra(addr[17:2]),
        .clka(clk),
        .douta(instruction)
    );
endmodule
