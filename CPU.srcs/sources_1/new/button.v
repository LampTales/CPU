`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 2023/05/17 14:29:28
// Design Name:
// Module Name: button
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


module button(input clk,
              input rst_n,
              input input_button,
              output reg output_button);
    reg [9:0] keycnt;
    reg enable;

    // keycnt
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || input_button || keycnt > 10'd200) begin
            keycnt <= 0;
        end
        else begin
            keycnt <= keycnt +1;
        end
    end

    // enable
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || keycnt == 10'd200)begin
            enable <= 1;
        end
        else if(input_button)begin
            enable <= 0;
            // enable <= 1;
        end
        else begin
            enable <= enable;
        end
    end
    
    // output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)begin
            output_button <= 0;
        end
        else if (input_button & enable)begin
            output_button <= 1;
        end
        else begin
            output_button <= 0;
        end
    end

    // always @(posedge clk or negedge rst_n) begin
    //     if (!rst_n) begin
    //         enable        <= 1;
    //         keycnt        <= 0;
    //         output_button <= 0;
    //     end
    //     else if (keycnt > 8'd100) begin
    //         keycnt <= 0;
    //         enable <= 1;
    //     end
    //     else begin
    //         if (input_button & enable)begin
    //             output_button <= 1;
    //             enable        <= 0;
    //             keycnt        <= 0;
    //         end
    //         else begin
    //             output_button <= 0;
    //             keycnt <= keycnt + 1;
    //         end
    //     end
    // end
endmodule
