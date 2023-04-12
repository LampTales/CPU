`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:21:19
// Design Name: 
// Module Name: MUX
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


module MUX_32(
    input [31:0] in0,
    input [31:0] in1,
    input select,
    output [31:0] out
    );

    assign out =  select ? in1 : in0;
    
endmodule

module MUX_5(
    input [4:0] in0,
    input [4:0] in1,
    input select,
    output [4:0] out
    );

    assign out =  select ? in1 : in0;
endmodule
