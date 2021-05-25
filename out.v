
module out( clk, rst, result,result2,result3,result4,result5,result6,result7,fn_sel,flag,out_en,out_en2,out_en3,out_en4,cycle_cnt,cnt,state,valid,iot_out);
input          clk;
input          rst;
input  [127:0] result;
input  [127:0] result2;
input  [127:0] result3;
input  [127:0] result4;
input  [127:0] result5;
input  [127:0] result6;
input  [127:0] result7;
input  [2:0]   fn_sel;
input          flag;
input          out_en;
input          out_en2;
input          out_en3;
input          out_en4;
input  [7:0]   cycle_cnt;
input   [5:0] cnt;
input   [2:0] state;
output reg   valid;
output reg[127:0] iot_out;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        iot_out<=0;
    end
    else begin
        if(state==3'b010)begin
            if(fn_sel==1)begin
                iot_out<=result;
            end
            else if(fn_sel==2)begin
                iot_out<=result2;
            end
            else if(fn_sel==3)begin
                iot_out<=result3;
            end
            else if(fn_sel==4)begin
                iot_out<=result4;
            end
            else if(fn_sel==5)begin
                iot_out<=result5;
            end
            else if(fn_sel==6)begin
                iot_out<=result6;
            end
            else begin
                iot_out<=result7;
            end
        end
        else begin
            iot_out<=0;
        end
    end
end



always@(posedge clk or posedge rst)begin
    if(rst)begin
        valid<=0;
    end
    else begin
        if(state==3'b010)begin
            if(fn_sel==4)begin
                if(out_en)begin
                    valid<=1;
                end
                else begin
                    valid<=0;
                end
            end
            else if(fn_sel==5)begin
                if(out_en2)begin
                    valid<=1;
                end
                else begin
                    valid<=0;
                end
            end
            else if(fn_sel==6)begin
                if(out_en3)begin
                    valid<=1;
                end
                else if(flag==0 & cycle_cnt == 7)begin
                    valid<=1;
                end
                else begin
                    valid<=0;
                end
            end
            else if(fn_sel==7)begin
                if(out_en4)begin
                    valid<=1;
                end
                else if(flag==0 & cycle_cnt == 7)begin
                    valid<=1;
                end
                else begin
                    valid<=0;
                end
            end
            else begin
                valid<=1;
            end
        end
        else begin
            valid<=0;
        end
    end
end

endmodule