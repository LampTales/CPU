`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
<<<<<<< HEAD
// Create Date: 2022/07/23 14:01:09
=======
// Create Date: 2023/05/17 14:29:28
>>>>>>> 031912858131a0fe513cac2a65970f1890690e6f
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


module button(
    input clk,
    input rst_n,
    input input_button,
    output reg output_button
    );
    reg [27:0] keycnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            keycnt <= 0;
            output_button <= 0;
        end
        
        else if(keycnt >= 28'd1_000_000) begin
            keycnt <= 0;
            output_button <= 0;
        end
        
        else begin
            keycnt <= keycnt + 1;
            output_button <= output_button | input_button;
        end
        
        
    end
endmodule
