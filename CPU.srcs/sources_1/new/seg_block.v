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


module seg_block(
    input clk,
    input rst,
    input [31:0] seg_in, //todo revise the length of seg_in
    output reg [7:0] seg_op,
    output reg [7:0] seg_out
    );
 
    reg [2:0] cnt;
    reg [3:0] hexadecimals [7:0];
    reg [3:0] current_hex;

    always @ (seg_in) begin
        hexadecimals[0] = seg_in[3:0];
        hexadecimals[1] = seg_in[7:4];
        hexadecimals[2] = seg_in[11:8];
        hexadecimals[3] = seg_in[15:12];
        hexadecimals[4] = seg_in[19:16];
        hexadecimals[5] = seg_in[23:20];
        hexadecimals[6] = seg_in[27:24];
        hexadecimals[7] = seg_in[31:28];
    end

    always @ (posedge clk or negedge rst) begin
        if (~rst) begin
            cnt <= 0;
            current_hex <= 0;
            seg_op <= 8'b1111_1111;
        end
        else begin
            cnt <= cnt + 1'b1;
        end
    end

    always @ (cnt) begin
        case(cnt)
            0: begin seg_op <= 8'b1111_1110; current_hex <= hexadecimals[0]; end
            1: begin seg_op <= 8'b1111_1101; current_hex <= hexadecimals[1]; end
            2: begin seg_op <= 8'b1111_1011; current_hex <= hexadecimals[2]; end
            3: begin seg_op <= 8'b1111_0111; current_hex <= hexadecimals[3]; end
            4: begin seg_op <= 8'b1110_1111; current_hex <= hexadecimals[4]; end
            5: begin seg_op <= 8'b1101_1111; current_hex <= hexadecimals[5]; end
            6: begin seg_op <= 8'b1011_1111; current_hex <= hexadecimals[6]; end
            7: begin seg_op <= 8'b0111_1111; current_hex <= hexadecimals[7]; end
            default: begin seg_op <= 8'b1111_1111; current_hex <= 0; end
        endcase
    end
    
always @ (current_hex) begin 
     case (current_hex)
         4'h0: seg_out = 8'b01000000; // 0
         4'h1: seg_out = 8'b01111001; // 1
         4'h2: seg_out = 8'b00100100; // 2
         4'h3: seg_out = 8'b00110000; // 3
         4'h4: seg_out = 8'b00011001; // 4
         4'h5: seg_out = 8'b00010010; // 5
         4'h6: seg_out = 8'b00000010; // 6
         4'h7: seg_out = 8'b01111000; // 7
         4'h8: seg_out = 8'b00000000; // 8
         4'h9: seg_out = 8'b00010000; // 9
         4'ha: seg_out = 8'b00001000; // A
         4'hb: seg_out = 8'b00000011; // b
         4'hc: seg_out = 8'b01000110; // c
         4'hd: seg_out = 8'b00100001; // d
         4'he: seg_out = 8'b00000110; // E
         4'hf: seg_out = 8'b00001110; // F
         default: seg_out = 8'b0000000;
     endcase
end    

endmodule
