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
    input pc_clk,
    input seg_clk,
    output [7:0] seg_op,
    output [7:0] seg_out,
    input rst,
    input cpu_rst_butt,
    input mode_butt,
    input ack_butt,
    output cpu_rst,
    output reg [1:0] mode,
    output ack,
    output [7:0] board_input_data,
    output [3:0] board_input_case,
    input [31:0] board_output_data,
    input [7:0] board_output_sig

    // the rest is hardware signal
    );

    seg_block seg(
        .clk(seg_clk),
        .rst(rst),
        .seg_in(board_output_data),
        .seg_op(seg_op),
        .seg_out(seg_out)
    );

    button cpu_rst_butt_antishake(
        .clk(pc_clk),
        .rst_n(rst),
        .input_button(cpu_rst_butt),
        .output_button(cpu_rst)
    );

    wire mode_change;
    button mode_butt_antishake(
        .clk(pc_clk),
        .rst_n(rst),
        .input_button(mode_butt),
        .output_button(mode_change)
    );

    always@(posedge mode_change or negedge rst) begin
        if(!rst) begin
            mode <= 2'b00;  // ori
        end
        else begin
            case(mode)
                2'b00: mode <= 2'b01;   // uart
                2'b01: mode <= 2'b10;   // run
                2'b10: mode <= 2'b11;   // debug
                2'b11: mode <= 2'b00;   //back to ori
            endcase
            end
    end


    button ack_butt_antishake(
        .clk(pc_clk),
        .rst_n(rst),
        .input_button(ack_butt),
        .output_button(ack)
    );

    
    

endmodule
