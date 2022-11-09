`timescale 1ns/1ns
module ISP_tb;
reg	  clk;   
reg  rst_n; 

reg  [23:0]  per_img;
wire  vs;
wire  hs;	 
wire  de; 
wire  uart_tx;

wire  post_frame_vsync; 
wire  post_frame_href; 
wire  post_frame_clken;

wire  [23:0]	     lcd_data;   



initial 
begin 
   rst_n<=1'b0;
   clk<=1'b0;
  #200
   rst_n<=1'b1;
end
always #5 clk = ~ clk;

reg [11:0]              hcount_r;
reg [11:0]              vcount_r;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin 
        hcount_r<=12'd0;
    end 
    else if (hcount_r==12'd1023)begin 
        hcount_r<=12'd0;
    end 
    else if(de==1'b1)begin 
        hcount_r<=hcount_r+1'b1;
    end 
    else begin 
        hcount_r<=12'd0;
    end 
end 
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin 
        vcount_r<=12'd0;
    end 
    else if ( hcount_r==12'd1023) begin
        if(vcount_r==12'd767 )begin 
            vcount_r<=12'd0;
        end 
        else begin 
            vcount_r<=vcount_r+1'b1;
        end 
     end
end 

always @(posedge clk or negedge rst_n)begin
 if(rst_n==1'b0)
   per_img<= 24'd0;

  else 
    if(hcount_r>12'd50&&hcount_r<12'd800&&de == 1'b1)

        per_img <= per_img + 1'b1;


   else     if(hcount_r>=12'd800||hcount_r<12'd50)

        per_img <= 24'd0;
   
   else     if(hcount_r==12'd50)

        per_img <= 24'd8696143;

    end
    
color_bar color_bar_m0(
	.clk(clk),
	.rst(~rst_n),
	.hs(hs),
	.vs(vs),
	.de(de),
	.rgb_r(),
	.rgb_g(),
	.rgb_b()
);

ISP ISP_m0 (

        . pixelclk(clk),
        .clk(clk),
        . rstin (rst_n)  ,
        . i_rgb (per_img)  ,
        . i_hsync(hs), 
        . i_vsync(vs ),
        . i_de(de),
        . uart_tx(uart_tx),

        . VGA_rgb(lcd_data) ,
        . VGA_hsync(post_frame_href    ),
        . VGA_vsync(post_frame_vsync    ),
        . VGA_de(post_frame_clken     )


);
  

endmodule