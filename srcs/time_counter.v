`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:10:59
// Design Name: 
// Module Name: time_counter
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


module time_counter(
    input wire clk_1hz,
    input wire rst,
    output reg [5:0] sec, min,
    output reg [4:0] hr
);
    always @(posedge clk_1hz or posedge rst) begin
        if (rst) begin
            sec <= 0; min <= 0; hr <= 0;
        end else begin
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
