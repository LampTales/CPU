`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 23:08:04
// Design Name: 
// Module Name: IO_block
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


module IO_block(
    input [23:0] switch_in,
    output [23:0] led_out,
    input seg_clk,
    output [7:0] seg_op,
    output [7:0] seg_out,
    input rst,
    input cpu_rst_butt,
    input mode_butt,
    input ack_butt,
    output [1:0] mode,
    output ack,
    output [7:0] board_input_data,
    output [3:0] board_input_case,
    input [31:0] board_output_data,
    input [7:0] board_output_sig
    );

    seg_block seg(
        .clk(seg_clk),
        .rst(rst),
        .seg_in(board_output_data),
        .seg_op(seg_op),
        .seg_out(seg_out)
    );


    

endmodule
