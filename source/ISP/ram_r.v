module ram_r #(
    parameter IMG_WIDTH_LINE = 1024
    )(
	input        clk,
	input        rst_n,
	
	input        en,
    input [11:0] waddr,
    input [11:0] raddr,
    input  [0:0] in_data,
    output [0:0] out_data
	);

reg [0:0] mem [0:IMG_WIDTH_LINE-1]; //800
reg [0:0] rdata;
assign out_data = rdata;

always @ (posedge clk or negedge rst_n)
   if (1'b0 == rst_n) begin
       rdata <= 0;
       end
   else begin
       if (en) mem[waddr] <= in_data;
       rdata <= mem[raddr];
       end	

endmodule 
