
module display(
        
      input						           pixelclk,
	  input                                reset_n,
      input                                red_en,
      input                                grenn_en,
      input                                blue_en,

  	   input          [23:0]                  i_rgb,
	   input						            i_hsync,
	   input							          i_vsync,
	   input							          i_de,
	   
	   input [11:0]                      hcount,
       input [11:0]                      vcount,

       input   [11:0]                     hcount_l,
       input   [11:0]                     hcount_r,
       input   [11:0]                     vcount_l,
       input   [11:0]                     vcount_r,
       input   [23:0]                     r_t,
  
    
       output         [23:0]              o_rgb,
	   output							            o_hsync,
	   output							           o_vsync,                                                                                                  
	   output						              o_de




 );



reg	   [23:0]            rgb_r;	
reg                       hsync_r;
reg                       vsync_r;
reg                       de_r;
       
always @(posedge pixelclk) begin
  hsync_r <= i_hsync;
  vsync_r <= i_vsync;
  de_r    <= i_de;
end

assign o_hsync = hsync_r;
assign o_vsync = vsync_r;
assign o_de    = de_r;
assign o_rgb   = rgb_r; 




always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    rgb_r <= 24'h00000;

  else begin
     if (vcount>vcount_l && vcount<vcount_r && ( hcount==hcount_l || hcount==hcount_r ))
    rgb_r <= 24'h00ff00;
  else if (hcount > hcount_l && hcount < hcount_r && (vcount== vcount_l || vcount== vcount_r ))
    rgb_r <= 24'h00ff00;
  else if (red_en)begin
      if (hcount > hcount_l && hcount < hcount_r && (vcount== vcount_l-2 || vcount== vcount_r-2 ))
      rgb_r<=r_t;
	  else
	  rgb_r<=i_rgb;
	  end
  else if (grenn_en)begin
      if (hcount > hcount_l && hcount < hcount_r && (vcount== vcount_l-2 || vcount== vcount_r-2 ))
      rgb_r<=r_t;
	  else
	  rgb_r<=i_rgb;
	  end  
  else if (blue_en)begin
      if (hcount > hcount_l && hcount < hcount_r && (vcount== vcount_l-2 || vcount== vcount_r-2 ))
	  
      rgb_r<=r_t;	  
	  else	  
	  rgb_r<=i_rgb;
	  
	  end
  else 
    rgb_r <= i_rgb;
    end


 end




endmodule