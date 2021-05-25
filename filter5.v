module filter5(clk, rst, fn_sel,cnt,data,state,valid,cycle_cnt,result5,out_en2);
input          clk;
input          rst;
input  [2:0]   fn_sel;
input  [5:0]   cnt;
input  [127:0]   data;
input  [2:0]     state;
input            valid;
input    [7:0] cycle_cnt;
output reg[127:0] result5;
output reg  out_en2;


reg[127:0] temp;


parameter high = 128'hBFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
parameter low =  128'h7FFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
 




always@(*)begin
    if(state==3'b010)begin
        if(data<low | data>high)begin
            result5=data;
            out_en2 = 1;
        end
        else begin
            result5=0;
            out_en2 = 0;
        end
    end
    else begin
        result5=0;
        out_en2 = 0;
    end
end



endmodule