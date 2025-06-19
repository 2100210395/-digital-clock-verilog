`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:32:15
// Design Name: 
// Module Name: tb_top
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


`timescale 1ns/1ps

module tb_top;

    reg clk = 0, rst = 1;
    reg [1:0] mode_sel = 0;
    reg [4:0] alarm_hr = 0, timer_hr = 0;
    reg [5:0] alarm_min = 0, alarm_sec = 5;
    reg [5:0] timer_min = 0, timer_sec = 10;
    reg alarm_en = 1, sw_rst = 0;

    wire [5:0] sec, min;
    wire [4:0] hr;
    wire alarm_flag, timer_done;

    // Instantiate
    top uut (
        .clk(clk), .rst(rst), .mode_sel(mode_sel), .sw_rst(sw_rst),
        .alarm_hr(alarm_hr), .alarm_min(alarm_min), .alarm_sec(alarm_sec), .alarm_en(alarm_en),
        .timer_hr(timer_hr), .timer_min(timer_min), .timer_sec(timer_sec),
        .sec(sec), .min(min), .hr(hr),
        .alarm_flag(alarm_flag), .timer_done(timer_done)
    );

    // Clock Generation (10ns = 100 MHz)
    always #5 clk = ~clk;

    initial begin
       // $dumpfile("waveform.vcd");
       // $dumpvars(0, tb_top);

        // Reset
        #10 rst = 0;

        // Clock mode: let time run for a few seconds
        mode_sel = 2'b00; #500;

        // Switch to stopwatch
        mode_sel = 2'b01; #500;

        // Reset stopwatch
        sw_rst = 1; #10; sw_rst = 0;

        // Switch to timer
        mode_sel = 2'b10; #500;

        $finish;
    end
endmodule



