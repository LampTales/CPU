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
           input[31:0] pc,
           input button,
           output reg [31:0] out);
    reg need_butt_intr;
    reg need_clk_intr;
    reg need_eret;
    reg exl;
    reg [31:0] epc;
    reg [31:0] cnt;
    always @(negedge clk or negedge rst) begin
        if (!rst)begin
            need_clk_intr <= 0;
            out           <= 0;
            exl           <= 0;
            cnt           <= 0;
        end
        cnt = cnt+1;
        if (need_eret) begin
            out <= epc;
            exl <= 0;
        end
        else if (!exl)begin
            if (need_butt_intr) begin
                exl <= 1;
                epc <= pc;
                out <= 4;
            end
            else if (need_clk_intr)begin
                exl <= 1;
                epc <= pc;
                out <= 4;
            end
            else begin
                out <= 0;
            end
        end
        else begin
            out <= 0;
        end
    end
    // button interrupt
    always @(posedge button or negedge clk or negedge rst) begin
        if(button) begin
            need_butt_intr <= 1;
        end
        else if (!exl | !rst)begin
            need_butt_intr <= 0;
        end
    end
    // clock interrupt
    always @(negedge clk or negedge rst) begin
        if(cnt[31]) begin
            need_clk_intr <= 1;
        end
        else if ((!clk & !exl) | !rst)begin
            need_clk_intr <= 0;
        end
    end

    always @(posedge eret or negedge clk or negedge rst) begin
        if (eret)begin
            need_eret <= 1;
        end
        else begin
            need_eret <= 0;
        end
    end
endmodule
