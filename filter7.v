
module filter7( clk, rst, fn_sel,cnt,data,state,valid,flag,cycle_cnt,result7,out_en4);
input          clk;
input          rst;
input  [2:0]   fn_sel;
input  [5:0]   cnt;
input  [127:0]   data;
input  [2:0]     state;
input            valid;
input            flag;
input    [7:0] cycle_cnt;
output reg[127:0] result7;
output reg         out_en4;




reg[127:0] temp,temp_min;






always@(posedge clk or posedge rst)begin
    if(rst)begin
        temp<=0;
    end
    else begin
        if(fn_sel==3'b111)begin
           if(cnt==16)begin
                temp<=result7;
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



always@(posedge clk or posedge rst)begin
    if(rst)begin
        temp_min<=0;
    end
    else begin
        if(flag==0 & state == 3'b010)begin
            temp_min<=result7;
        end
        else if(flag==1 & state == 3'b010 & result7<temp_min)begin
            temp_min<=result7;
        end
        else begin
            temp_min<=temp_min;
        end
    end
end



always@(*)begin
    if((cnt==16 & flag==0) | (cnt==16 & flag==1))begin
        if(temp==0 & flag==0)begin
            result7=data;
        end
        else if(data<temp)begin
            result7=data;
        end
        else begin
            result7=temp;
        end
    end
    else begin
        result7=0;
    end
end



always@(*)begin
    if(flag==1 & result7<temp_min & state == 3'b010)begin
        out_en4 = 1;
    end
    else begin
        out_en4 = 0;
    end
end



endmodule