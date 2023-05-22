`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/11 17:46:15
// Design Name: 
// Module Name: PCctrl
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

// build doing

module PCctrl(
    input [31:0] pc,
    input j,
    input jal,
    input [25:0] j_inst,
    input branch,
    input nbranch,
    input equal,
    input [31:0] expand_imme,
    input jr,
    input [31:0] ra,
    output [31:0] link_addr,
    output [31:0] next,

    input[31:0] interrupt_handler
    );
    wire [31:0] pc_add_4_dest;
    assign pc_add_4_dest = pc + 4;
    assign link_addr = pc_add_4_dest;

    wire [31:0] j_dest;
    reg [31:0] zero;
    assign j_dest = {pc[31:28], j_inst[25:0], zero[1:0]};

    wire [31:0] branch_dest;
    assign branch_dest = pc_add_4_dest + {expand_imme[29:0], zero[1:0]};

    wire pcadd4_branch_select;
    assign pcadd4_branch_select = (equal & branch) | ((~equal) & nbranch);
    wire [31:0] mux0_out;
    MUX_32 pcadd4_or_branch(
        .in0(pc_add_4_dest),
        .in1(branch_dest),
        .select(pcadd4_branch_select),
        .out(mux0_out)
    );

    wire mux0_jump_select;
    assign mux0_jump_select = j | jal;
    wire [31:0] mux1_out;
    MUX_32 mux0_or_jump(
        .in0(mux0_out),
        .in1(j_dest),
        .select(mux0_jump_select),
        .out(mux1_out)
    );

    wire mux2_jr_select;
    assign mux2_jr_select = jr;
    wire [31:0] mux2_out;
    MUX_32 mux2_or_jr(
        .in0(mux1_out),
        .in1(ra),
        .select(mux2_jr_select),
        .out(mux2_out)
    );

    assign next = mux2_out;
    // ICU interrupt from WYR
    // assign next = (interrupt_handler==0) ? mux2_out : interrupt_handler;

endmodule
