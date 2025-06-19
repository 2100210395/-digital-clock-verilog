`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 22:26:27
// Design Name: 
// Module Name: alarm
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


module alarm (
    input [4:0] hr, input [5:0] min, input [5:0] sec,
    input [4:0] alarm_hr, input [5:0] alarm_min, input [5:0] alarm_sec,
    input alarm_en,
    output reg alarm_flag
);
    always @(*) begin
        if (alarm_en && hr == alarm_hr && min == alarm_min && sec == alarm_sec)
            alarm_flag = 1;
        else
            alarm_flag = 0;
    end
endmodule
