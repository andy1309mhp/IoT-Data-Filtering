module filter3(clk, rst, fn_sel,cnt,data,state,valid,cycle_cnt,result3);
input          clk;
input          rst;
input  [2:0]   fn_sel;
input  [5:0]   cnt;
input  [127:0]   data;
input  [2:0]     state;
input            valid;
input    [7:0] cycle_cnt;

output reg[127:0] result3;




reg[130:0] temp;






always@(posedge clk or posedge rst)begin
    if(rst)begin
        temp<=0;
    end
    else begin
        if(fn_sel==3'b011)begin
            if(valid)begin
                temp<=0;
            end
            else if(cnt==15)begin
                temp<=temp+data;
            end
            else begin
                temp<=temp;
            end
        end
        else begin
            temp<=0;
        end
    end
end




always@(*)begin
    if(state==3'b010)begin
        result3 = temp+data>>3;
    end
    else begin
        result3=0;
    end
end



endmodule