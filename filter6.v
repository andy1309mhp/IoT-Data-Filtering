
module filter6( clk, rst, fn_sel,cnt,data,state,valid,flag,cycle_cnt,result6,out_en3);
input          clk;
input          rst;
input  [2:0]   fn_sel;
input  [5:0]   cnt;
input  [127:0]   data;
input  [2:0]     state;
input            valid;
input            flag;
input    [7:0] cycle_cnt;
output reg[127:0] result6;
output reg         out_en3;




reg[127:0] temp,temp_max;






always@(posedge clk or posedge rst)begin
    if(rst)begin
        temp<=0;
    end
    else begin
        if(fn_sel==3'b110)begin
           if(cnt==16)begin
                temp<=result6;
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
        temp_max<=0;
    end
    else begin
        if(flag==0 & state == 3'b010)begin
            temp_max<=result6;
        end
        else if(flag==1 & state == 3'b010 & result6>temp_max)begin
            temp_max<=result6;
        end
        else begin
            temp_max<=temp_max;
        end
    end
end



always@(*)begin
    if((cnt==16 & flag==0) | (cnt==16 & flag==1))begin
        if(data>temp)begin
            result6=data;
        end
        else begin
            result6=temp;
        end
    end
    else begin
        result6=0;
    end
end



always@(*)begin
    if(fn_sel==3'b110)begin
        if(flag==1 & result6>temp_max & state == 3'b010)begin
            out_en3 = 1;
        end
        else begin
            out_en3 = 0;
        end
    end
    else begin
        out_en3 = 0;
    end
end



endmodule