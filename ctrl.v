module ctrl( clk, rst, in_en,iot_in, fn_sel,out_en,out_en2,out_en3,out_en4,cycle_cnt,cnt, busy,data,state,flag);
input          clk;
input          rst;
input          in_en;
input  [7:0]   iot_in;
input  [2:0]   fn_sel;
input          out_en;
input          out_en2;
input          out_en3;
input          out_en4;
output  reg[5:0]  cnt;
output  reg       busy;
output  reg[127:0]  data;
output  reg[7:0]   cycle_cnt;
output  reg[2:0] state;
output  reg         flag;

reg[2:0]  next_state;
parameter IDLE = 3'b000;
parameter INPUT = 3'b001;
parameter WAIT = 3'b010;
parameter OUTPUT = 3'b011;


integer i;


reg[5:0] counter;
reg[7:0] buff_in[0:15];

always@(posedge clk or posedge rst)begin
    if(rst)begin
        state<=IDLE;
    end
    else begin
        state<=next_state;
    end
end



always@(posedge clk or posedge rst)begin
    if(rst)begin
        cycle_cnt<=0;
    end
    else begin
        if(cnt == 16 & cycle_cnt!=7)begin
            cycle_cnt<=cycle_cnt+1;
        end
        else if(cycle_cnt==7 & state == WAIT)begin
            cycle_cnt<=0;
        end
        else begin
            cycle_cnt<=cycle_cnt;
        end
    end
end


always@(posedge clk or posedge rst)begin
    if(rst)begin
        flag<=0;
    end
    else begin
        if(cycle_cnt==7 & state == WAIT)begin
            flag<=1;
        end
        else begin
            flag<=flag;
        end
    end
end






always@(posedge clk or posedge rst)begin
    if(rst)begin
        busy<=1;
    end
    else begin
        if(state == INPUT)begin
            if(cnt==14 | cnt==15)begin
                busy<=1;
            end
            else begin
                busy<=0;
            end
        end
        else begin
            busy<=0;
        end
    end
end






always@(posedge clk or posedge rst)begin
    if(rst)begin
        for(i=0;i<16;i=i+1)begin
            buff_in[i]<=0;
        end
    end
    else begin
        if(state == INPUT)begin
            if(cnt==15)begin
               for(i=0;i<16;i=i+1)begin
                   buff_in[i]<=0;
                end 
            end
            else begin
                buff_in[cnt]<=iot_in;
            end
        end
        else begin
            for(i=0;i<16;i=i+1)begin
                buff_in[i]<=0;
            end 
        end
    end
end






always@(posedge clk or posedge rst)begin
    if(rst)begin
        data<=0;
    end
    else begin
        if(cnt==15)begin
            data<={buff_in[0],buff_in[1],buff_in[2],buff_in[3],buff_in[4],buff_in[5],buff_in[6],buff_in[7],
            buff_in[8],buff_in[9],buff_in[10],buff_in[11],buff_in[12],buff_in[13],buff_in[14],iot_in};
        end
        else begin
            if(state==OUTPUT)begin
                data<=0;
            end
            else begin
                data<=data;
            end
        end
    end
end






always@(posedge clk or posedge rst)begin
    if(rst)begin
        cnt<=0;
    end
    else begin
        if(in_en)begin
            if(cnt==16)begin
                cnt<=0;
            end
            else begin
                cnt<=cnt+1;
            end
        end
        else begin
            cnt<=0;
        end
    end
end


always@(*)begin
    case(state)
        IDLE:begin
            next_state = INPUT;
        end
        INPUT:begin
            if(fn_sel == 3'b001 | fn_sel==3'b010 | fn_sel == 3'b011 | fn_sel == 3'b110 | fn_sel == 3'b111)begin //min max average
                if(cycle_cnt==7 & cnt == 15)begin
                    next_state = WAIT;
                end
                else begin
                    next_state = state;
                end
            end
            else begin //extract
                if(cnt==15)begin
                    next_state = WAIT;
                end
                else begin
                    next_state = state;
                end
            end
        end
        WAIT:begin
            if(fn_sel == 3'b100 | fn_sel == 3'b101)begin
                if(out_en | out_en2)begin
                    next_state = OUTPUT;
                end
                else begin
                    next_state = INPUT;
                end
            end
            else begin
                if(fn_sel == 3'b110)begin
                    if(!flag)begin
                        next_state = OUTPUT;
                    end
                    else if(out_en3)begin
                        next_state = OUTPUT;
                    end
                    else begin
                        next_state = INPUT;
                    end
                end
                else if(fn_sel == 3'b111)begin
                    if(!flag)begin
                        next_state = OUTPUT;
                    end
                    else if(out_en4)begin
                        next_state = OUTPUT;
                    end
                    else begin
                        next_state = INPUT;
                    end
                end
                else begin
                    next_state = OUTPUT;
                end
            end
        end
        OUTPUT:begin
            next_state = INPUT;
        end
        default: next_state = IDLE;
    endcase
end

endmodule