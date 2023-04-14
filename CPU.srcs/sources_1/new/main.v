`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:21:43
// Design Name: 
// Module Name: main
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


module main(
    input clk,
    input sysrst,
    output [23:0] led_out,
    output [7:0] seg_op,
    output [7:0] seg_out
    );

    // what should be the rst?
    assign rst = sysrst;
    wire rom_clk;
    wire ram_clk;
    wire reg_clk;
    wire pc_clk;

    CXK clock(
        .clk(clk),
        .rst(rst),
        .rom_clk(rom_clk),
        .ram_clk(ram_clk),
        .reg_clk(reg_clk),
        .pc_clk(pc_clk)
    );

    wire [31:0] pc_next;
    wire [31:0] pc_value;
    PC pc_counter(
        .clk(pc_clk),
        .rst(rst),
        .next(pc_next),
        .out(pc_value)
    );

    wire [31:0] instruction;
    ROM rom(
        .clk(rom_clk),
        .rst(rst),
        .addr(pc_value),
        .instruction(instruction)
    );

    wire ignore;
    wire [31:0] expand_imme;
    Expander expander(
        .imme(instruction[15:0]),
        .ignore(ignore),
        .expand_imme(expand_imme)
    );
    
    wire [5:0] alu_op;
    wire [4:0] shamt;
    wire reg_dst;
    wire branch;
    wire nbranch;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_src;
    wire reg_write;
    wire simd;
    wire j;
    wire jr;
    wire jal;
    CTRL ctrl(
        .op_code(instruction[31:26]),
        .shamt_in(instruction[10:6]),
        .func_code(instruction[5:0]),
        .alu_op(alu_op),
        .shamt_out(shamt),
        .reg_dst(reg_dst),
        .branch(branch),
        .nbranch(nbranch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .ignore(ignore),
        .simd(simd),
        .j(j),
        .jr(jr),
        .jal(jal)
    );

    reg [4:0] ra_addr = 31;
    wire [4:0] read0_select;
    MUX_5 read0_which_reg(
        .in0(instruction[25:21]),
        .in1(ra_addr),
        .select(jr),
        .out(read0_select)
    );
    wire [4:0] write_select0;
    MUX_5 write_which_reg0(
        .in0(instruction[20:16]),
        .in1(instruction[15:11]),
        .select(reg_dst),
        .out(write_select0)
    );
    wire [4:0] write_select1;
    MUX_5 write_which_reg1(
        .in0(write_select0),
        .in1(ra_addr),
        .select(jal),
        .out(write_select1)
    );

    wire [31:0] reg_write_data;
    wire [127:0] simd_reg_write_data;
    wire [31:0] reg_read_data0;
    wire [31:0] reg_read_data1;
    wire [127:0] simd_reg_read_data0;
    wire [127:0] simd_reg_read_data1;
    REG reg_file(
        .clk(reg_clk),
        .rst(rst),
        .read0(read0_select),
        .read1(instruction[20:16]),
        .write(write_select1),
        .write_data(reg_write_data),
        .simd_write_data(simd_reg_write_data),
        .reg_write(reg_write),
        .simd(simd),
        .read_data0(reg_read_data0),
        .read_data1(reg_read_data1),
        .simd_read_data0(simd_reg_read_data0),
        .simd_read_data1(simd_reg_read_data1)
    );

    wire [31:0] data_to_alu_select;
    MUX_32 which_data_to_alu(
    .in0(reg_read_data1),
    .in1(expand_imme),
    .select(alu_src),
    .out(data_to_alu_select)
    );

    wire [31:0] alu_result;
    wire alu_equal;
    ALU alu(
        .alu_op(alu_op),
        .shamt(shamt),
        .in0(reg_read_data0),
        .in1(data_to_alu_select),
        .out(alu_result),
        .equal(alu_equal)
    );

    SIMD_ALU simd_alu(
        .alu_op(alu_op),
        .in0(simd_reg_read_data0),
        .in1(simd_reg_read_data1),
        .out(simd_reg_write_data)
    );

    wire [31:0] mem_read_data;
    RAM ram(
        .clk(ram_clk),
        .rst(rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(reg_read_data1),
        .read_data(mem_read_data)
    );

    wire [31:0] write_data_to_reg_select;
    MUX_32 which_write_data_to_reg(
        .in0(alu_result),
        .in1(mem_read_data),
        .select(mem_to_reg),
        .out(write_data_to_reg_select)
    );
    wire [31:0] link_addr;
    MUX_32 whether_write_ra_or_not(
        .in0(write_data_to_reg_select),
        .in1(link_addr),
        .select(jal),
        .out(reg_write_data)
    );

    PCctrl pc_ctrl(
        .pc(pc_value),
        .j(j),
        .jal(jal),
        .j_inst(instruction[25:0]),
        .branch(branch),
        .nbranch(nbranch),
        .equal(alu_equal),
        .expand_imme(expand_imme),
        .jr(jr),
        .ra(reg_read_data0),
        .link_addr(link_addr),
        .next(pc_next)
    );


endmodule
