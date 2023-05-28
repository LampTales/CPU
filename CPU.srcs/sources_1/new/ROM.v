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
    input [31:0] addr,
    output [31:0] instruction,
    
    input kickOff, uart_out_clk, uart_out_wen, 
    input [13:0] uart_out_addr,
    input [31:0] uart_out_data    
    
    );
    
    ram_ip_for_rom ram_for_rom(
        .clka(kickOff ? clk : uart_out_clk),
        .addra(kickOff ? addr[13:2] : uart_out_addr[13:2]), 
        .douta(instruction),
        .dina(uart_out_data),
        .wea(uart_write_en)
    );
    
endmodule
