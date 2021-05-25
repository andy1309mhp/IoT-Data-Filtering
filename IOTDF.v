`timescale 1ns/10ps
`include "ctrl.v"
`include "filter1.v"
`include "filter2.v"
`include "filter3.v"
`include "filter4.v"
`include "filter5.v"
`include "filter6.v"
`include "filter7.v"
`include "out.v"
module IOTDF( clk, rst, in_en, iot_in, fn_sel, busy, valid, iot_out);
input          clk;
input          rst;
input          in_en;
input  [7:0]   iot_in;
input  [2:0]   fn_sel;
output         busy;
output         valid;
output[127:0] iot_out;

wire[5:0] cnt;
wire[127:0] data;
wire[127:0] result,result2,result3,result4,result5,result6,result7;
wire[7:0] cycle_cnt;
wire[2:0] state;
wire out_en,out_en2,out_en3,out_en4,flag;

ctrl ctrl0(.clk(clk),
           .rst(rst),
           .in_en(in_en),
           .iot_in(iot_in),
           .fn_sel(fn_sel),
           .out_en(out_en),
           .out_en2(out_en2),
           .out_en3(out_en3),
           .out_en4(out_en4),
           .cycle_cnt(cycle_cnt),
           .cnt(cnt),
           .busy(busy),
           .data(data),
           .state(state),
           .flag(flag)
           );


filter1 f1(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .cycle_cnt(cycle_cnt),
          .result(result)
        );

filter2 f2(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .cycle_cnt(cycle_cnt),
          .result2(result2)
        );



filter3 f3(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .cycle_cnt(cycle_cnt),
          .result3(result3)
        );



filter4 f4(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .cycle_cnt(cycle_cnt),
          .result4(result4),
          .out_en(out_en)
        );

filter5 f5(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .cycle_cnt(cycle_cnt),
          .result5(result5),
          .out_en2(out_en2)
        );



filter6 f6(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .flag(flag),
          .cycle_cnt(cycle_cnt),
          .result6(result6),
          .out_en3(out_en3)
        );


filter7 f7(.clk(clk),
          .rst(rst),
          .fn_sel(fn_sel),
          .cnt(cnt),
          .data(data),
          .state(state),
          .valid(valid),
          .flag(flag),
          .cycle_cnt(cycle_cnt),
          .result7(result7),
          .out_en4(out_en4)
        );

out mux_out(.clk(clk),
            .rst(rst),
            .result(result),
            .result2(result2),
            .result3(result3),
            .result4(result4),
            .result5(result5),
            .result6(result6),
            .result7(result7),
            .fn_sel(fn_sel),
            .flag(flag),
            .out_en(out_en),
            .out_en2(out_en2),
            .out_en3(out_en3),
            .out_en4(out_en4),
            .cycle_cnt(cycle_cnt),
            .cnt(cnt),
            .state(state),
            .valid(valid),
            .iot_out(iot_out)
         );




endmodule
