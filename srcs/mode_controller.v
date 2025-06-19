`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:29:56
// Design Name: 
// Module Name: mode_controller
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

module mode_controller (
    input [1:0] mode_sel,
    output reg clk_en,sw_rst, sw_en,  tm_en
    
);
    always @(*) begin
        clk_en = 0; sw_en = 0; sw_rst = 0; tm_en = 0;
        case (mode_sel)
            2'b00: clk_en = 1;        // Clock
            2'b01: sw_en  = 1;        // Stopwatch
            2'b10: tm_en  = 1;        // Timer
            default: ;
        endcase
    end
endmodule
