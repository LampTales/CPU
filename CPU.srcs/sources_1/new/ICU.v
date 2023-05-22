`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/18
// Design Name:
// Module Name: ICU
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

module ICU(input clk,
           input rst,
           input eret,
           input pc,
           input button,
           output reg [31:0] out);
           
    reg [1:0]need_interrupt;
    reg need_eret;
    reg exl;
    reg [31:0] epc;
    reg [31:0] cnt;
    reg [31:0] handler;
    always @(negedge rst) begin
        need_interrupt = 0;
        out            = 0;
        exl            = 0;
        cnt            = 0;
    end
    always @(posedge clk) begin
        cnt = cnt+1;
    end
    always @(negedge clk) begin
        if (need_eret) begin
            need_eret <= 0;
            out <= epc;
            exl <= 0;
        end
        else if (~exl)begin
            if (need_interrupt[0]) begin
                need_interrupt[0] = 0;
                exl = 1;
                epc = pc+4;
                out <= handler;
            end
            else if (need_interrupt[1])begin
                need_interrupt[1] = 0;
                exl = 1;
                epc = pc+4;
                out <= handler;
            end
        end
        else begin
            out <= 0;
        end
    end
    // button interrupt
    always @(posedge button) begin
        need_interrupt[0] =  1;
    end
    // clock interrupt
    always @(posedge cnt[31]) begin
        need_interrupt[1] =  1;
    end
    always @(posedge eret) begin
        need_eret = 1;
    end
endmodule
