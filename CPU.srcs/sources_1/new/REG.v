`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/10 15:25:32
// Design Name: 
// Module Name: REG
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


module REG(
    input clk,
    input rst,
    input [4:0] read0,
    input [4:0] read1,
    input [4:0] write,
    input [31:0] write_data,
    input [127:0] simd_write_data,
    input reg_write,
    input simd,
    output [31:0] read_data0,
    output [31:0] read_data1,
    output [127:0] simd_read_data0,
    output [127:0] simd_read_data1,
    input ack
    );
    reg [1023:0] save;

    // reg write
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            save[31:0] <= 0; // zero
            save[959:928] <= 2'b00000000000000001111111100000000;

        end
        else if(reg_write) begin
            case(write)
                3: save[127:96] <= write_data;
                4: save[159:128] <= write_data;
                5: save[191:160] <= write_data;
                6: save[223:192] <= write_data;
                7: save[255:224] <= write_data;
                8: save[287:256] <= write_data;
                9: save[319:288] <= write_data;
                10: save[351:320] <= write_data;
                11: save[383:352] <= write_data;
                12: save[415:384] <= write_data;
                13: save[447:416] <= write_data;
                14: save[479:448] <= write_data;
                15: save[511:480] <= write_data;
                16: save[543:512] <= write_data;
                17: save[575:544] <= write_data;
                18: save[607:576] <= write_data;
                19: save[639:608] <= write_data;
                20: save[671:640] <= write_data;
                21: save[703:672] <= write_data;
                22: save[735:704] <= write_data;
                23: save[767:736] <= write_data;
                24: save[799:768] <= write_data;
                25: save[831:800] <= write_data;
                26: save[863:832] <= write_data;
                27: save[895:864] <= write_data;
                28: save[927:896] <= write_data;
                29: save[959:928] <= write_data;
                30: save[991:960] <= write_data;
                31: save[1023:992] <= write_data;
                default: save[31:0] <= 0;
            endcase
        end
    end

    // reg read
    always @(read0) begin
        case(read0)
            
        endcase
    end

endmodule
