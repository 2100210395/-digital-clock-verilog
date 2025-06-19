`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:28:22
// Design Name: 
// Module Name: timer
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

module timer (
    input clk_1hz,
    input rst,
    input tm_en, // Timer enable (one-time load trigger)
    input [4:0] init_hr,
    input [5:0] init_min,
    input [5:0] init_sec,
    output reg [5:0] sec, min,
    output reg [4:0] hr,
    output reg timer_done
);

    reg started = 0;

    always @(posedge clk_1hz or posedge rst) begin
        if (rst) begin
            hr <= 0;
            min <= 0;
            sec <= 0;
            timer_done <= 0;
            started <= 0;
        end else if (tm_en && !started) begin
            // Load timer values once when tm_en is high
            hr <= init_hr;
            min <= init_min;
            sec <= init_sec;
            timer_done <= 0;
            started <= 1;
        end else if (started && !timer_done) begin
            // Countdown logic
            if (hr == 0 && min == 0 && sec == 0) begin
                timer_done <= 1;
            end else begin
                if (sec > 0)
                    sec <= sec - 1;
                else begin
                    sec <= 59;
                    if (min > 0)
                        min <= min - 1;
                    else begin
                        min <= 59;
                        if (hr > 0)
                            hr <= hr - 1;
                    end
                end
            end
        end
    end

endmodule