`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:21:43
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input sysrst,
    output [23:0] led_out,
    output [7:0] seg_op,
    output [7:0] seg_out
    );

    // what should be the rst?
    assign rst = sysrst;
    wire rom_clk;
    wire ram_clk;
    wire reg_clk;
    wire pc_clk;

    CXK clock(
        .clk(clk),
        .rst(rst),
        .rom_clk(rom_clk),
        .ram_clk(ram_clk),
        .reg_clk(reg_clk),
        .pc_clk(pc_clk)
    );

    wire pc_next;
    wire pc_value;
    PC pc_counter(
        .clk(pc_clk),
        .rst(rst),
        .next(pc_next),
        .out(pc_value)
    );

    wire [31:0] instruction;
    ROM rom(
        .clk(clk),
        .rst(rst),
        .addr(pc_value),
        .instruction(instruction)
    );

    




endmodule
