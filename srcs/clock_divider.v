`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2025 21:50:21
// Design Name: 
// Module Name: clock_divider
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


module clock_divider #(parameter DIV=10)(
          input wire clk,
          input wire rst,
          output reg clk_1hz
          );

   reg[31:0]count;
   always@(posedge clk or posedge rst)begin
     if(rst) begin
        count<=0;
        clk_1hz<=0;
     end else begin
        if(count==DIV/2 - 1)begin
        clk_1hz<=~clk_1hz;
        count <=0;
     end else 
        count <= count + 1;
     end
  end  
endmodule
