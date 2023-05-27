`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/10 19:20:56
// Design Name:
// Module Name: seg_block
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


/*
 todo:
 (a) fix the multi-driving problem
 */


module seg_block(input clk,
                 input rst,
                 input [31:0] seg_in,       //todo revise the length of seg_in
                 output reg [7:0] seg_op,
                 output reg [7:0] seg_out);
    
    reg [12:0] cnt;
    reg [3:0] hexadecimals [7:0];
    reg [3:0] current_hex;
    
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            cnt         <= 0;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end
    
    always @(*) begin
        case(cnt[12:10])
        0: seg_op = 8'b1111_1110;
        1: seg_op = 8'b1111_1101;
        2: seg_op = 8'b1111_1011;
        3: seg_op = 8'b1111_0111;
        4: seg_op = 8'b1110_1111;
        5: seg_op = 8'b1101_1111;
        6: seg_op = 8'b1011_1111;
        7: seg_op = 8'b0111_1111;
        default: seg_op = 8'b1111_1111;
        endcase
    end

    always @(*) begin
        case(cnt[12:10])
        0: current_hex = hexadecimals[0];
        1: current_hex = hexadecimals[1];
        2: current_hex = hexadecimals[2];
        3: current_hex = hexadecimals[3];
        4: current_hex = hexadecimals[4];
        5: current_hex = hexadecimals[5];
        6: current_hex = hexadecimals[6];
        7: current_hex = hexadecimals[7];
        default: current_hex = 0;
        endcase
    end

   //TODO FIX SEG_OUT 
    always @ (*) begin
        case (current_hex)
            4'h0: seg_out    = 8'hc0;
            4'h1: seg_out    = 8'hf9;
            4'h2: seg_out    = 8'ha4; // 2
            4'h3: seg_out    = 8'hb0; // 3
            4'h4: seg_out    = 8'h99; // 4
            4'h5: seg_out    = 8'h92; // 5
            4'h6: seg_out    = 8'h82; // 6
            4'h7: seg_out    = 8'hf8; // 7
            4'h8: seg_out    = 8'h80; // 8
            4'h9: seg_out    = 8'h90; // 9
            4'ha: seg_out    = 8'h88; // A
            4'hb: seg_out    = 8'h83; // b
            4'hc: seg_out    = 8'hc6; // c
            4'hd: seg_out    = 8'ha1; // d
            4'he: seg_out    = 8'h86; // E
            4'hf: seg_out    = 8'hbf; // -
            default: seg_out = 8'b0000000;
        endcase
    end
    
endmodule
