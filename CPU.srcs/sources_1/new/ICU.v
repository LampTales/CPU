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
    reg [1:0] exl;
    reg [31:0] epc;
    reg [31:0] cnt;
    // always @(posedge clk or negedge rst) begin
    //     if (!rst)begin
    //         out           <= 0;
    //         exl           <= 0;
    //     end
    //     else if (eret) begin
    //         out <= epc;
    //         exl <= 0;
    //     end
    //     else if (!exl)begin
    //         if (need_butt_intr) begin
    //             exl <= 1;
    //             epc <= pc;
    //             out <= 4;
    //         end
    //         else if (need_clk_intr)begin
    //             exl <= 1;
    //             epc <= pc;
    //             out <= 4;
    //         end
    //         else begin
    //             out <= 0;
    //         end
    //     end
    //     else begin
    //         out <= 0;
    //     end
    // end

    //epc
    always @(posedge clk or negedge rst) begin
        if(!rst)begin
            epc<=0;
        end
        else if(!exl&(need_butt_intr|need_clk_intr))begin
            epc<=pc;
        end
        else begin
            epc<=epc;
        end
    end


    // exl
    always @(posedge clk or negedge rst) begin
        if(!rst|eret)begin
            exl <= 0;
        end
        else if(need_butt_intr)begin
            exl <= 1;
        end
        else if(need_clk_intr)begin
            exl <= 2; 
        end
        else begin
            exl<=exl;
        end
    end

    // out
    always @(posedge clk or negedge rst) begin
        if (!rst)begin
            out <= 0;
        end
        else if(eret)begin
            out<= epc;
        end
        else if(!exl & need_butt_intr)begin
            out<=4;
        end
        else if (!exl & need_clk_intr)begin
            out<=12;
        end
        else begin
            out<=0;
        end
    end

    // button interrupt
    always @(negedge clk or negedge rst) begin
        if(!rst)begin
            need_butt_intr <= 0;
        end
        else if(button) begin
            need_butt_intr <= 1;
        end
        else begin
            need_butt_intr <= 0;
        end
    end

    // clock interrupt
    always @(negedge clk or negedge rst) begin
        if(!rst)begin
            cnt<=0;
            need_clk_intr <=0;
        end
        else if(cnt > 32'd1526) begin
            cnt <=0;
            need_clk_intr <= 1;
        end
        else if (exl==1)begin
            cnt <=cnt+1;
            need_clk_intr <= need_clk_intr;
        end
        else begin
            cnt <= cnt+1;
            need_clk_intr <= 0;
        end
    end
endmodule
