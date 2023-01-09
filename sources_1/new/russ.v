`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/08 22:03:40
// Design Name: 
// Module Name: russ
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

//对时钟做分频，产生1Hz的分频信号控制蜂鸣器发声。
module russ(
            input sys_clk_i,	//外部输入50MHz时钟信号
			input ext_rst_n,	//外部输入复位信号，低电平有效
			output reg beep		//蜂鸣器控制信号，1--响，0--不响	
		);													
//要产生1Hz的蜂鸣器驱动信号，则需要对50MHz（20ns）的输入时钟sys_clk_i做分频计数为：
//1000_000_000ns/20ns=50_000_000（从0计数到49_999_999）
//-------------------------------------
reg[27:0] cnt;		//20位计数器

always @ (posedge sys_clk_i or negedge ext_rst_n)	
	if(!ext_rst_n) cnt <= 28'd0;
	else if(cnt < 28'd49_999_999) cnt <= cnt+1'b1;
	else cnt <= 28'd0;

//-------------------------------------

	//产生频率为1Hz，占空比为50%的蜂鸣器发声信号
always @ (posedge sys_clk_i or negedge ext_rst_n) 
	if(!ext_rst_n) beep <= 1'b0;
	else if(cnt < 28'd24_999_999) beep <= 1'b1;	//蜂鸣器响
	else beep <= 1'b0;		//蜂鸣器不响
    ;
endmodule

