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
    output reg [31:0] read_data0,
    output reg [31:0] read_data1,
    output reg [127:0] simd_read_data0,
    output reg [127:0] simd_read_data1,
    input ack
    );
    reg [1023:0] save;

    

    // ack cnt
    reg [31:0] ack_v0;
    always @(posedge ack or negedge rst) begin
        if(!rst) ack_v0 <= 0;
        else ack_v0 <= ack_v0 + 1;
    end

    // reg read
    always @(*) begin
        case(read0)
            0: read_data0 = save[31:0];
            1: read_data0 = save[63:32];
            2: read_data0 = ack_v0;
            3: read_data0 = save[127:96];
            4: read_data0 = save[159:128];
            5: read_data0 = save[191:160];
            6: read_data0 = save[223:192];
            7: read_data0 = save[255:224];
            8: read_data0 = save[287:256];
            9: read_data0 = save[319:288];
            10: read_data0 = save[351:320];
            11: read_data0 = save[383:352];
            12: read_data0 = save[415:384];
            13: read_data0 = save[447:416];
            14: read_data0 = save[479:448];
            15: read_data0 = save[511:480];
            16: read_data0 = save[543:512];
            17: read_data0 = save[575:544];
            18: read_data0 = save[607:576];
            19: read_data0 = save[639:608];
            20: read_data0 = save[671:640];
            21: read_data0 = save[703:672];
            22: read_data0 = save[735:704];
            23: read_data0 = save[767:736];
            24: read_data0 = save[799:768];
            25: read_data0 = save[831:800];
            26: read_data0 = save[863:832];
            27: read_data0 = save[895:864];
            28: read_data0 = save[927:896];
            29: read_data0 = save[959:928];
            30: read_data0 = save[991:960];
            31: read_data0 = save[1023:992];
            default: read_data0 = 0;
        endcase
    end

    always @(*) begin
        case(read1) 
            0: read_data1 = save[31:0];
            1: read_data1 = save[63:32];
            2: read_data1 = ack_v0;
            3: read_data1 = save[127:96];
            4: read_data1 = save[159:128];
            5: read_data1 = save[191:160];
            6: read_data1 = save[223:192];
            7: read_data1 = save[255:224];
            8: read_data1 = save[287:256];
            9: read_data1 = save[319:288];
            10: read_data1 = save[351:320];
            11: read_data1 = save[383:352];
            12: read_data1 = save[415:384];
            13: read_data1 = save[447:416];
            14: read_data1 = save[479:448];
            15: read_data1 = save[511:480];
            16: read_data1 = save[543:512];
            17: read_data1 = save[575:544];
            18: read_data1 = save[607:576];
            19: read_data1 = save[639:608];
            20: read_data1 = save[671:640];
            21: read_data1 = save[703:672];
            22: read_data1 = save[735:704];
            23: read_data1 = save[767:736];
            24: read_data1 = save[799:768];
            25: read_data1 = save[831:800];
            26: read_data1 = save[863:832];
            27: read_data1 = save[895:864];
            28: read_data1 = save[927:896];
            29: read_data1 = save[959:928];
            30: read_data1 = save[991:960];
            31: read_data1 = save[1023:992];
            default: read_data1 = 0;
        endcase
    end



    always @(*) begin
        case(read0)
            3: simd_read_data0 = save[223:96];
            4: simd_read_data0 = save[255:128];
            5: simd_read_data0 = save[287:160];
            6: simd_read_data0 = save[319:192];
            7: simd_read_data0 = save[351:224];
            8: simd_read_data0 = save[383:256];
            9: simd_read_data0 = save[415:288];
            10: simd_read_data0 = save[447:320];
            11: simd_read_data0 = save[479:352];
            12: simd_read_data0 = save[511:384];
            13: simd_read_data0 = save[543:416];
            14: simd_read_data0 = save[575:448];
            15: simd_read_data0 = save[607:480];
            16: simd_read_data0 = save[639:512];
            17: simd_read_data0 = save[671:544];
            18: simd_read_data0 = save[703:576];
            19: simd_read_data0 = save[735:608];
            20: simd_read_data0 = save[767:640];
            21: simd_read_data0 = save[799:672];
            22: simd_read_data0 = save[831:704];
            23: simd_read_data0 = save[863:736];
            24: simd_read_data0 = save[895:768];
            default: simd_read_data0 = 0;

        endcase
    end

    always @(*) begin
        case(read1)
            3: simd_read_data1 = save[223:96];
            4: simd_read_data1 = save[255:128];
            5: simd_read_data1 = save[287:160];
            6: simd_read_data1 = save[319:192];
            7: simd_read_data1 = save[351:224];
            8: simd_read_data1 = save[383:256];
            9: simd_read_data1 = save[415:288];
            10: simd_read_data1 = save[447:320];
            11: simd_read_data1 = save[479:352];
            12: simd_read_data1 = save[511:384];
            13: simd_read_data1 = save[543:416];
            14: simd_read_data1 = save[575:448];
            15: simd_read_data1 = save[607:480];
            16: simd_read_data1 = save[639:512];
            17: simd_read_data1 = save[671:544];
            18: simd_read_data1 = save[703:576];
            19: simd_read_data1 = save[735:608];
            20: simd_read_data1 = save[767:640];
            21: simd_read_data1 = save[799:672];
            22: simd_read_data1 = save[831:704];
            23: simd_read_data1 = save[863:736];
            24: simd_read_data1 = save[895:768];
            default: simd_read_data1 = 0;

        endcase
    end


// reg write
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            save[31:0] <= 0;  // $zero
            save[927:96] <= 0;  // common regs
            save[959:928] <= 32'b00000000000000000011111100000000;  // $sp

        end
        else if(reg_write) begin

            if(simd) begin
                case(write)
                3: save[223:96] <= simd_write_data;
                4: save[255:128] <= simd_write_data;
                5: save[287:160] <= simd_write_data;
                6: save[319:192] <= simd_write_data;
                7: save[351:224] <= simd_write_data;
                8: save[383:256] <= simd_write_data;
                9: save[415:288] <= simd_write_data;
                10: save[447:320] <= simd_write_data;
                11: save[479:352] <= simd_write_data;
                12: save[511:384] <= simd_write_data;
                13: save[543:416] <= simd_write_data;
                14: save[575:448] <= simd_write_data;
                15: save[607:480] <= simd_write_data;
                16: save[639:512] <= simd_write_data;
                17: save[671:544] <= simd_write_data;
                18: save[703:576] <= simd_write_data;
                19: save[735:608] <= simd_write_data;
                20: save[767:640] <= simd_write_data;
                21: save[799:672] <= simd_write_data;
                22: save[831:704] <= simd_write_data;
                23: save[863:736] <= simd_write_data;
                24: save[895:768] <= simd_write_data;
                default: save[31:0] <= 0;
                endcase
            end
            else begin
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
    end

endmodule
