module area_1(
input					pixelclk,
input                   rst_n,
input                   en,
input                   i_binary,
input					i_hs,
input					i_vs,
input					i_de,
//input     [23:0]        i_rgb_1,
//
//output    [23:0]        o_rgb_1_6,
output    wire           hs_r,
output    wire           vs_r,
output    wire           de_r,
output    wire			post_frame_vsync,
output    wire			post_frame_href,	
output    wire			post_frame_clken,	
output    wire			post_img_Bit




   );


 
 assign hs_r    = i_hs;
 assign vs_r    =i_vs;
 assign de_r    = i_de;

               

 assign   post_frame_vsync=i_vs ;  
 assign   post_frame_href =i_hs  ;	 
 assign   post_frame_clken=i_de ;	 
 assign   post_img_Bit =i_binary ;  




	

 
endmodule