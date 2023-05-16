`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 00:30:17
// Design Name: 
// Module Name: RAM
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


module RAM(
    input clk,
    input rst,
    input mem_read,
    input mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data,
    input [7:0] in_num,
    output [7:0] out_num,
    output 
    );
    wire [31:0] ram_out;
    ram_ip inner_ram(
        .addra(addr[17:2]),
        .clka(clk),
        .dina(write_data),
        .douta(ram_out),
        .wea(mem_write)
    );

    wire [31:0] board_input;
    assign board_input = in_num;
    assign read_data = (addr == 32'b0000 0000 0000 0000 1111 1111 1111 0000) ? board_input : ram_out;

    // todo: make mem_write branch
endmodule
