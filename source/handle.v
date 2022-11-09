module handle(
input					pixelclk,
input                   rstin,
input                   en,
input     [23:0]        i_binary_1,
input     [23:0]        i_rgb_1   ,
input                   i_hsync_1 ,
input                   i_vsync_1 ,
input                   i_de_1    ,
input                   x0        ,
input                   x1        ,
input                   x2        ,
input                   x3        ,
input                   x4        ,
input                   x5        ,
input                   x6        ,
input                   x7        ,
input                   x8        ,
input                   x9        ,
input                   x10       ,
input                   x11       ,



output     wire			post01_frame_vsync,  
output     wire			post01_frame_href,	 
output     wire			post01_frame_clken, 
output     wire			post01_img_Bit,    
output     wire [23:0]     s0,
output     wire [23:0]     s1,
output     wire [23:0]     s2,
output     wire [23:0]     s3,
output     wire [23:0]     s4,
output     wire [23:0]     s5,
output     wire [23:0]     s6,
output     wire [23:0]     s7,
output     wire [23:0]     s8,
output     wire [23:0]     s9,
output     wire [23:0]     s10,
output     wire [23:0]     s11,

output     wire            hs_r,
output     wire            vs_r,
output     wire            de_r    

//output     wire [23:0]  sobel_data1

   );



area  area_0_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x0),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),
    .hs_r               (hs_r),
    .vs_r               (vs_r),
    .de_r               (de_r),
//    .i_rgb_1            (i_rgb_1),
    .post_img_Bit       (post01_img_Bit),
	.post_frame_vsync   (post01_frame_vsync),	
	.post_frame_href    (post01_frame_href),	
	.post_frame_clken   (post01_frame_clken)	


   );


                  
area_colour  area_colour_1_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x1),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),


	         
    .s0                (s1)

   );



                  
area_colour  area_colour_2_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x2),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),


	
         
    .s0                (s2)

   );



                  
area_colour  area_colour_3_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x3),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                (t3),           
    .s0                (s3)

   );



                  
area_colour  area_colour_4_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),

    .i_binary           (x4),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),


	
//    .t1                (t4),           
    .s0                (s4)

   );



                  
area_colour  area_colour_5_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x5),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                (t5),           
    .s0                (s5)

   );



                  
area_colour  area_colour_6_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x6),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                (t6),           
    .s0                (s6)

   );


             
area_colour  area_colour_7_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x7),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                (t7),           
    .s0                (s7)

   );



                  
area_colour  area_colour_8_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x8),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),


	
//    .t1                (t8),           
    .s0                (s8)

   );



                  
area_colour  area_colour_9_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x9),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                (t9),           
    .s0                (s9)

   );



                  
area_colour  area_colour_10_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x10),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                 (t10),           
    .s0                 (s10)

   );

                  
area_colour  area_colour_11_inst
(
	.pixelclk           (pixelclk),
    .rst_n              (rstin),
    .en                 (en),
    .i_binary           (x11),
	.i_hs               (i_hsync_1),
	.i_vs               (i_vsync_1),
	.i_de               (i_de_1),

	
//    .t1                 (t11),           
    .s0                 (s11)

   );



endmodule