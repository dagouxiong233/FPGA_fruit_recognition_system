module win_buf(
rst_n,
clk,
din_valid,   //输入有效
din,   //输入数据流
dout,  //输出向量
dout__org, //输出中心像素值
vsync, //输入场同步
vsync_out,//输出场同步
is_boarder,//边界信息
dout_valid//输出有效
);
parameter DW=14;//数据位宽
parameter KSZ=15;//处理窗口
parameter IH=512;//图像高度
parameter Iw =640;//图像宽度
input rst_n;
input clk;
input din_valid;input [DW-1:0]din;
output [ DW*KSZ*KSZ-1:0]dout;
//输出为KSZ*KSZ向量
output [DW-1:0] dout_org;
//输出中心像素
input vsync;
output vsync_out;
output is_boarder;
output dout_valid;
localparam num all = KSZ *KSZ;//窗口数据总数
//窗口寄存器
reg [DW-1:0]p[O:num_al1-1];

//例化KSz-1个行缓存
generate

begin : line_buf

genvar i;
for (i - 0; i<= KSZ - 2;i= i+1)begin : buf_inst
line_buffer #(DW, Iw)
fine buf_inst(
.rst (rst_all),
.clk(clk),
.din (line_din[i][DW - 1:0]),
.dout (line_dout[i] [DW - 1:0]),
.wr_en (line_wren[i]),
.rd_en (line_rden[i]),
.empty(line_empty[i]),
.ful1(line_ful1[i]),
.count (line_count[i])
);
end
end
endgenerate//将输入接入延时电路
if (valid == 1'b1)p[0]<=#1 din;
//列延迟电路
for(k =0; k<= KSZ - 1;k=k +1)
for (-1;j<- KSZ-1;j- j+1)
if((line_valid[k* KSZ +j-1]) -= 1'b1)
p[k* KSZ+j]<=#1 p[k * KSZ+1-1];
//行延迟电路
for (k-1; k<= KSZ- 1;k-k + 1)
if ((line_rden[k - 1])-= 1'b1)
P[k* KSZ]<= #1 line_dout[k-1];
//输出窗口缓存
generate
begin : xhdl2
genvar i;
for (i=l;i<= num_all; i =i+1)
begin :out_dat_gen
assign dout[i *DW -1:(i- 1)* Dw] =p[i- 1;
end
end
endgenerate
//输出中心像素
assign dout_org =p[med_idx];
