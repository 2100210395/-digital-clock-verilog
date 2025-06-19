`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 13:00:57
// Design Name: 
// Module Name: timer_tb
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


module timer_tb;


    reg clk = 0;
    reg rst = 1;
    reg tm_en = 0;
    reg [4:0] init_hr = 0;
    reg [5:0] init_min = 0;
    reg [5:0] init_sec = 5;

    wire [4:0] hr;
    wire [5:0] min, sec;
    wire timer_done;
    wire stop_watch_done;

    // Instantiate the Timer module
    timer uut (
        .clk_1hz(clk),
        .rst(rst),
        .tm_en(tm_en),
        .init_hr(init_hr),
        .init_min(init_min),
        .init_sec(init_sec),
        .sec(sec),
        .min(min),
        .hr(hr),
        .timer_done(timer_done),
        .stop_watch_done(stop_watch_done)
    );

    // Clock generation: 10ns period (100 MHz), but we treat it as 1Hz for simulation
    always #5 clk = ~clk;

    initial begin
       // $dumpfile("timer_waveform.vcd");
        //$dumpvars(0, tb_timer);

        // Reset
        #10 rst = 0;

        // Trigger timer load
        #10 tm_en = 1;
        #10 tm_en = 0;

        // Wait long enough to let the timer finish
        #200;

        $finish;
    end

endmodule
