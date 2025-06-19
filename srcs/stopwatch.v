`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:27:38
// Design Name: 
// Module Name: stopwatch
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


module stopwatch (
    input clk_1hz, input rst, input sw_en, input sw_rst,
    output reg [5:0] sec, min,
    output reg [4:0] hr
    
);
    always @(posedge clk_1hz or posedge rst) begin
        if (rst || sw_rst) begin
            sec <= 0; min <= 0; hr <= 0;
        end else if (sw_en) begin
            if (sec == 59) begin
                sec <= 0;
                if (min == 59) begin
                    min <= 0;
                    if (hr == 23)
                        hr <= 0;
                    else
                        hr <= hr + 1;
                end else
                    min <= min + 1;
            end else
                sec <= sec + 1;
        end
    end
endmodule
