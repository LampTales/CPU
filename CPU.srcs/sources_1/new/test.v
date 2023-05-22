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
    reg cpu_rst_butt;
    reg mode_butt;
    reg ack_butt;
    reg [23:0] switch_in;
    wire [23:0] led_out;
    wire [7:0] seg_op;
    wire [7:0] seg_out;
    wire uart_in;
    wire uart_out;
    main u_main(
    	.clk          (clk          ),
        .sysrst       (sysrst       ),
        .cpu_rst_butt (cpu_rst_butt ),
        .mode_butt    (mode_butt    ),
        .ack_butt     (ack_butt     ),
        .switch_in    (switch_in    ),
        .led_out      (led_out      ),
        .seg_op       (seg_op       ),
        .seg_out      (seg_out      ),
        .uart_in      (uart_in      ),
        .uart_out     (uart_out     )
    );
    initial begin
        clk = 0;
        sysrst = 1;
        cpu_rst_butt = 1;
        mode_butt = 0;
        ack_butt = 0;
        switch_in = 0;
    end

endmodule
