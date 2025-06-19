`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:30:42
// Design Name: 
// Module Name: top
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
module top (
    input clk, input rst,
    input [1:0] mode_sel,
    input  sw_rst,
    input [4:0] alarm_hr, input [5:0] alarm_min, alarm_sec,
    input alarm_en,
    input [4:0] timer_hr, input [5:0] timer_min, timer_sec,
    output [5:0] sec, min,
    output [4:0] hr,
    output alarm_flag, timer_done
);
    
    wire clk_1hz;
    wire clk_en, sw_en, tm_en;

    // Internal wires for different modules
    wire [5:0] rtc_sec, rtc_min;
    wire [4:0] rtc_hr;

    wire [5:0] timer_sec_out, timer_min_out;
    wire [4:0] timer_hr_out;

    // 1 Hz Clock Divider (for simulation use small divisor)
    clock_divider #(10) u_clk_div (
        .clk(clk), 
        .rst(rst), 
        .clk_1hz(clk_1hz)
    );

    // Mode Controller
    mode_controller u_mode (
        .mode_sel(mode_sel), 
        .clk_en(clk_en), 
        .sw_en(sw_en), 
        .sw_rst(sw_rst), 
        .tm_en(tm_en)
    );

    // Real-Time Clock
    time_counter u_rtc (
        .clk_1hz(clk_1hz & clk_en), 
        .rst(rst), 
        .sec(rtc_sec), 
        .min(rtc_min), 
        .hr(rtc_hr)
    );

    // Alarm Module
    alarm u_alarm (
        .hr(rtc_hr), 
        .min(rtc_min), 
        .sec(rtc_sec),
        .alarm_hr(alarm_hr), 
        .alarm_min(alarm_min), 
        .alarm_sec(alarm_sec),
        .alarm_en(alarm_en), 
        .alarm_flag(alarm_flag)
    );

    // Stopwatch Module
    stopwatch u_sw (
        .clk_1hz(clk_1hz), 
        .rst(rst), 
        .sw_en(sw_en), 
        .sw_rst(sw_rst),
        .sec(), .min(), .hr()  // Not connected to top outputs
    );

    // Timer Module
    timer u_timer (
        .clk_1hz(clk_1hz),
        .rst(rst),
        .tm_en(tm_en),
        .init_hr(timer_hr),
        .init_min(timer_min),
        .init_sec(timer_sec),
        .sec(timer_sec_out),
        .min(timer_min_out),
        .hr(timer_hr_out),
        .timer_done(timer_done)
    );

    // Output selection based on mode_sel
    // mode_sel:
    //   00 - Real Time Clock
    //   01 - Stopwatch
    //   10 - Timer

    assign sec = (mode_sel == 2'b10) ? timer_sec_out : rtc_sec;
    assign min = (mode_sel == 2'b10) ? timer_min_out : rtc_min;
    assign hr  = (mode_sel == 2'b10) ? timer_hr_out  : rtc_hr;

endmodule

