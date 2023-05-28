`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/12 00:30:17
// Design Name:
// Module Name: RAM
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


module RAM(input clk,
           input rst,
           input mem_read,
           input mem_write,
           input [31:0] addr,
           input [31:0] write_data,
           output reg [31:0] read_data,
           input [7:0] in_num,
           input [2:0] in_case,
           output [31:0] out_num,
           output [7:0] out_sig);
    wire [31:0] ram_out;
    wire [31:0] ram_in;
    ram_ip inner_ram(
    .addra(addr[15:2]),
    .clka(clk),
    .dina(write_data),
    .douta(ram_out),
    .wea(mem_write)
    );
    
    wire [31:0] board_input_data;
    assign board_input_data = in_num;
    wire [31:0] board_input_case;
    assign board_input_case = in_case;


    // always@(*) begin
    //     casex(addr)
    //         32'b00000000000000000011111111110000: read_data = board_input_data;
    //         32'b00000000000000000011111111110100: read_data = board_input_case;
    //         default: read_data                              = ram_out;
    //     endcase
    // end
    
    // reg [31:0] inner_addr;

    // with star
    always@(*) begin
        casex(addr[15:2])
            14'b00111111111100: read_data = board_input_data;
            14'b00111111111101: read_data = board_input_case;
            default: read_data = ram_out;
        endcase
    end

    
    reg [31:0] board_output_data;
    assign out_num = board_output_data;
    reg [31:0] board_output_sig;
    assign out_sig = board_output_sig;
    

    // always@(*) begin
    //     if (!rst) begin
    //         board_output_data = 0;
    //         board_output_sig  = 0;
    //     end
    //     else begin
    //     casex(addr)
    //         32'b0000 0000 0000 0000 0011111111111000: board_output_data = (mem_write) ? write_data : board_output_data;
    //         32'b00000000000000000011111111111100: board_output_sig  = (mem_write) ? write_data : board_output_sig;
    //     endcase
    //     end
    // end

    // now it work with the inner_ram
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            board_output_data <= 0;
            board_output_sig  <= 0;
        end
        else if (mem_write) begin
        case (addr[15:2])
            14'b00111111111110: board_output_data <= write_data;
            14'b00111111111111: board_output_sig <= write_data;
        endcase
        end

        
    end

endmodule
