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
           output [31:0] out);
    reg need_interrupt;
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
        handler        = 0;
    end
    always @(posedge clk) begin
        cnt = cnt+1;
    end
    always @(negedge clk) begin
        if (need_eret) begin
            out <= epc;
            exl <= 0;
        end
        else if (need_interrupt) begin
            out <= handler;
        end
        else begin
            out <= 0;
        end
        need_interrupt <= 0;
        need_eret      <= 0;
    end
    // button interrupt
    always @(posedge button) begin
        if (!exl) begin
            need_interrupt = 1;
            exl            = 1;
            cause          = 1;
            epc            = pc+4;
        end
    end
    // clock interrupt
    always @(posedge cnt[31]) begin
        if (!exl) begin
            need_interrupt = 1;
            exl            = 1;
            cause          = 2;
            epc            = pc+4;
        end
    end
    always @(posedge eret) begin
        need_eret = 1;
    end
endmodule
