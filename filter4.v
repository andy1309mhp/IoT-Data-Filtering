module filter4(clk, rst, fn_sel,cnt,data,state,valid,cycle_cnt,result4,out_en);
input          clk;
input          rst;
input  [2:0]   fn_sel;
input  [5:0]   cnt;
input  [127:0]   data;
input  [2:0]     state;
input            valid;
input    [7:0] cycle_cnt;
output reg[127:0] result4;
output reg  out_en;


reg[127:0] temp;


parameter high = 128'hAFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
parameter low =  128'h6FFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
 




always@(*)begin
    if(state==3'b010)begin
        if(data>low & data<high)begin
            result4=data;
            out_en = 1;
        end
        else begin
            result4=0;
            out_en = 0;
        end
    end
    else begin
        result4=0;
        out_en = 0;
    end
end



endmodule