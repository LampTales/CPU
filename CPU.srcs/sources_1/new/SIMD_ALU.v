`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/14 10:30:12
// Design Name: 
// Module Name: SIMD_ALU
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


module SIMD_ALU(
    input [5:0] alu_op,
    input [127:0] in0,
    input [127:0] in1,
    output [127:0] out
    );
    reg [4:0] shamt_zero;
    ALU inner_alu0(
        .alu_op(alu_op),
        .shamt(shamt_zero),
        .in0(in0[127:96]),
        .in1(in1[127:96]),
        .out(out[127:96])
    );
    ALU inner_alu1(
        .alu_op(alu_op),
        .shamt(shamt_zero),
        .in0(in0[95:64]),
        .in1(in1[95:64]),
        .out(out[95:64])
    );
    ALU inner_alu2(
        .alu_op(alu_op),
        .shamt(shamt_zero),
        .in0(in0[63:32]),
        .in1(in1[63:32]),
        .out(out[63:32])
    );
    ALU inner_alu3(
        .alu_op(alu_op),
        .shamt(shamt_zero),
        .in0(in0[31:0]),
        .in1(in1[31:0]),
        .out(out[31:0])
    );


endmodule


