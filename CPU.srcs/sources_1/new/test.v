`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:02:35
// Design Name: 
// Module Name: test
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


module test;


    reg clk;
    reg sysrst;
    reg mode_butt;
    reg ack_butt;
    reg cpu_rst_butt;
    reg intr_butt;
    reg [23:0] switch_in;
    wire [23:0] led_out;
    wire [7:0] seg_op;
    wire [7:0] seg_out;
    reg uart_in;
    wire uart_out;

    wire rst;
    assign rst = sysrst;
    wire rom_clk;
    wire ram_clk;
    wire reg_clk;
    wire pc_clk;
    wire seg_clk;
    wire uart_clk;
    reg icu_clk;

    wire cpu_rst_out;
    wire [1:0] mode;
    wire ack;

    wire cpu_rst = rst & !cpu_rst_out;

initial begin
    clk          = 0;
    icu_clk      = 1;
    sysrst       = 1;
    cpu_rst_butt = 0;
    mode_butt    = 0;
    ack_butt     = 0;
    switch_in    = 24'hffffff;
    intr_butt =0;

    #10
    sysrst = 0;
    cpu_rst_butt = 1;
    #10
    sysrst = 1;
    cpu_rst_butt = 0;
    #100
    intr_butt =1;
    #5
    intr_butt =0;
end
always #10 clk           = ~clk;
always@(clk) #5  icu_clk = ~icu_clk;

    CXK clock(
        .clk(clk),
        .rst(rst),
        .rom_clk(rom_clk),
        .ram_clk(ram_clk),
        .reg_clk(reg_clk),
        .pc_clk(pc_clk),
        .seg_clk(seg_clk),
        .uart_clk(uart_clk)
    );

    wire [31:0] pc_next;
    wire [31:0] pc_value;
    PC pc_counter(
        .clk(pc_clk),
        .rst(cpu_rst),
        .next(pc_next),
        .out(pc_value)
    );

    wire [31:0] instruction;
    ROM rom(
        .clk(rom_clk),
        .rst(cpu_rst),
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

    wire [11:0] alu_op;
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
    wire eret;
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
        .jal(jal),
        .eret(eret)
    );

    wire interrupt;
    wire intr_butt_out;
    assign intr_butt_out = intr_butt;
    wire[31:0] icu_out;
    ICU icu(
        .clk(icu_clk),
        .rst(cpu_rst),
        .eret(eret),
        .pc(pc_next),
        .button(intr_butt_out),
        .out(icu_out)
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
        .rst(cpu_rst),
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
        .simd_read_data1(simd_reg_read_data1),
        .ack(ack)
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
    wire [7:0] errorcode;
    ALU alu(
        .alu_op(alu_op),
        .shamt(shamt),
        .in0(reg_read_data0),
        .in1(data_to_alu_select),
        .out(alu_result),
        .equal(alu_equal),
        .errorcode(errorcode)
    );

    SIMD_ALU simd_alu(
        .alu_op(alu_op),
        .in0(simd_reg_read_data0),
        .in1(simd_reg_read_data1),
        .out(simd_reg_write_data)
    );

    wire [31:0] mem_read_data;
    wire [7:0] in_num;
    wire [3:0] in_case;
    wire [31:0] out_num;
    wire [7:0] out_sig;
    RAM ram(
        .clk(ram_clk),
        .rst(cpu_rst),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(reg_read_data1),
        .read_data(mem_read_data),
        .in_num(in_num),
        .in_case(in_case),
        .out_num(out_num),
        .out_sig(out_sig)
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
        .interrupt_handler(icu_out),
        .link_addr(link_addr),
        .next(pc_next)
    );

    IO_block io_block(
        .switch_in(switch_in),
        .led_out(led_out),
        .pc_clk(pc_clk),
        .seg_clk(seg_clk),
        .seg_op(seg_op),
        .seg_out(seg_out),
        .rst(rst),
        .cpu_rst_butt(cpu_rst_butt),
        .mode_butt(mode_butt),
        .ack_butt(ack_butt),
        .intr_butt(intr_butt),
        .interrupt(interrupt),
        .cpu_rst(cpu_rst_out),
        .mode(mode),
        .ack(ack),
        .board_input_data(in_num),
        .board_input_case(in_case),
        .board_output_data(out_num),
        .board_output_sig(out_sig),
        .errorcode(errorcode)
    );

    wire uart_out_clk;
    wire uart_out_wen;
    wire [13:0] uart_out_addr;
    wire [31:0] uart_out_data;
    wire uart_out_done;
    uart_bmpg_0 uart_block(
        .upg_clk_i(uart_clk),
        .upg_rst_i(rst),
        .upg_rx_i(uart_in),
        .upg_clk_o(uart_out_clk),
        .upg_wen_o(uart_out_wen),
        .upg_adr_o(uart_out_addr),
        .upg_dat_o(uart_out_data),
        .upg_done_o(uart_out_done),
        .upg_tx_o(uart_out)
    );
endmodule
