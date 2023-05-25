`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 00:09:10
// Design Name: 
// Module Name: CXK
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


module CXK(
    input clk,
    input rst,
    output rom_clk,
    output ram_clk,
    output reg_clk,
    output pc_clk,
    output seg_clk,
    output uart_clk,
    output icu_clk
    );
    wire cpu_clk;
    // assign cpu_clk = clk;
    clk_ip inner_clk(
        .clk_in1(clk),
        .cpu_clk(cpu_clk),
        .seg_clk(seg_clk),
        .uart_clk(uart_clk),
        .icu_clk(icu_clk)
    );
    // assign seg_clk = clk;
    assign pc_clk = cpu_clk;
    assign ram_clk = cpu_clk;
    assign rom_clk = ~cpu_clk;
    assign reg_clk = ~cpu_clk;
endmodule
