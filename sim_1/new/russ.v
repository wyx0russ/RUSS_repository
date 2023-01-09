`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/08 22:43:45
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


`timescale 1ns/1ps
module sim_russ();
	
reg sys_clk_i;	//50MHz时钟信号
reg ext_rst_n;	//复位信号，低电平有效
wire beep;	//蜂鸣器控制信号，1--响，0--不响		
	
russ		uut_russ(
			.sys_clk_i(sys_clk_i),	//外部输入50MHz时钟信号
			.ext_rst_n(ext_rst_n),	//外部输入复位信号，低电平有效
			.beep(beep)		//蜂鸣器控制信号，1--响，0--不响
		);			
	
initial begin
	sys_clk_i = 0;
	ext_rst_n = 0;	//复位中
	#1000;
	@(posedge sys_clk_i); #2;
	ext_rst_n = 1;	//复位结束，正常工作
	repeat(10) #1_000_000_000;
	$finish;
end	
	
always #10 sys_clk_i = ~sys_clk_i;	//50MHz时钟产生
	
endmodule
//这是个测试
//这是个测试plus
