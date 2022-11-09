module judge_single_1
(
    input						    pixelclk ,
    input                           reset_n  ,
                                             
    input          [23:0]           i_rgb    ,
    input						    i_hsync  ,
    input							i_vsync  ,
    input							i_de     ,
    input                           en      ,                                         
    input          [11:0]           hcount  ,
    input          [11:0]           vcount  ,
    
    input            [11:0]          hcount_l,
    input            [11:0]          hcount_r,
    input            [11:0]          vcount_l,
    input            [11:0]          vcount_r,

    output           [11:0]          hcount_l1,
    output           [11:0]          hcount_r1,
    output           [11:0]          vcount_l1,
    output           [11:0]          vcount_r1,     
    output          [3:0]            sort,
    output          [7:0]            t0,
    output          [7:0]            r_t, 
    output          [23:0]           judge_rgb,
    output                           judge_hsync ,
    output                           judge_vsync, 
    output                           judge_de   
);

wire      [11:0]           hcount_1  ;
wire      [11:0]           vcount_1  ; 
wire      [23:0]           o_rgb_s;
wire                       o_hsync_s;
wire                       o_vsync_s;
wire                       o_de_s   ;                 
                                  
capture_single  capture_single0_inst(

        .pixelclk         (pixelclk),
	    .reset_n          (reset_n), 
                          
        .i_rgb            (i_rgb),
        .i_hsync          (i_hsync),
        .i_vsync          (i_vsync ),
        .i_de             (i_de),
                          
	    .hcount           (hcount),
	    .vcount           (vcount),
                          
        .hcount_l         (hcount_l),
        .hcount_r         (hcount_r),
        .vcount_l         (vcount_l),
        .vcount_r         (vcount_r),
                    
        .o_rgb          (o_rgb_s),
        .o_hsync        (o_hsync_s),
        .o_vsync        (o_vsync_s),                                                                                                  
        .o_de           (o_de_s)                                                                                           
	   );
wire    [23:0]            o_rgb_y;
wire    [23:0]            o_ycbcr_y0;
wire                      o_hsync_y0;
wire                      o_vsync_y0;                             
wire                      o_de_y0; 

rgb2ycbcr rgb2ycbcr0(
       .pixelclk   (pixelclk),
	   .rst_n      (reset_n) ,
       .i_rgb      (o_rgb_s),
       .i_hsync    (o_hsync_s),
       .i_vsync    (o_vsync_s),
       .i_de       (o_de_s),
//       .i_de0      (),
       
       .o_rgb      (o_rgb_y),
       .o_ycbcr    (o_ycbcr_y0),
       .o_hsync    (o_hsync_y0),
       .o_vsync    (o_vsync_y0),    
//       .o_de0      (),                          
       .o_de       (o_de_y0)                                                                                        
);

wire [23:0]          o_binary_1 ;
wire [23:0]          o_rgb_1    ;
wire                 o_hsync_1  ;
wire                 o_vsync_1  ;
wire                 o_de_1     ;
wire                 x0        ;
wire                 x1        ;
wire                 x2        ;
wire                 x3        ;
wire                 x4        ;
wire                 x5        ;
wire                 x6        ;
wire                 x7        ;
wire                 x8        ;
wire                 x9        ;
wire                 x10       ;
wire                 x11       ;
//wire                 en        ;

threshold_binary  threshold_binary0(
        .pixelclk         (pixelclk),
        .reset_n          (reset_n),
        .i_ycbcr          (o_ycbcr_y0),
        .i_rgb            (o_rgb_y),
        .i_hsync          (o_hsync_y0),
        .i_vsync          (o_vsync_y0),
        .i_de             (o_de_y0),
        .x0               (x0),		
        .x1               (x1),
        .x2               (x2),
        .x3               (x3),
        .x4               (x4),
	    .x5               (x5),
        .x6               (x6),
        .x7               (x7),
        .x8               (x8),
        .x9               (x9),
        .x10              (x10), 
        .x11              (x11),		
        .o_binary         (o_binary_1),
        .o_rgb            (o_rgb_1),
        .o_hsync          (o_hsync_1),
        .o_vsync          (o_vsync_1),   
        .o_de             (o_de_1)                                                                                         
);

wire			post01_frame_vsync;  
wire			post01_frame_href;	 
wire			post01_frame_clken;	 
wire			post01_img_Bit;     
wire [23:0]     s0;
wire            hs_r;
wire            vs_r;
wire            de_r;



wire  [23:0]          s1;
wire  [23:0]          s2;
wire  [23:0]          s3;
wire  [23:0]          s4;
wire  [23:0]          s5;
wire  [23:0]          s6;
wire  [23:0]          s7;
wire  [23:0]          s8;
wire  [23:0]          s9;
wire  [23:0]          s10;
wire  [23:0]          s11;
                  

//wire [23:0]  sobel_data1;

handle_1    handle_inst(
    .pixelclk          (pixelclk),
    .rstin             (reset_n),
    .en                (1'b1),
    .i_binary_1        (o_binary_1),
    .i_rgb_1           (o_rgb_1),
    .i_hsync_1         (o_hsync_1 ),
    .i_vsync_1         (o_vsync_1),
    .i_de_1            (o_de_1),
    .x0                (x0),
    .x1                (x1),
    .x2                (x2),
    .x3                (x3),
    .x4                (x4),
    .x5                (x5),
    .x6                (x6),
    .x7                (x7),
    .x8                (x8),
    .x9                (x9),
    .x10               (x10),
    .x11               (x11),
                       
    .post01_frame_vsync(post01_frame_vsync),  
    .post01_frame_href (post01_frame_href ),	 
    .post01_frame_clken(post01_frame_clken), 
    .post01_img_Bit    (post01_img_Bit), 

//    .post01_img_Bit   (post01_img_Bit), 
//	.post01_frame_href (judge_hsync) ,
//    .post01_frame_vsync(judge_vsync),                                                                                                  
//	.post01_frame_clken(judge_de   ),   
//    .s0                (s0),
    .s1                (s1),
    .s2                (s2),
    .s3                (s3),
    .s4                (s4),
    .s5                (s5),
    .s6                (s6),
    .s7                (s7),
    .s8                (s8),
    .s9                (s9),
    .s10               (s10),
    .s11               (s11),
                      
    .hs_r              (),
    .vs_r              (),
    .de_r              (),
                     
    . t0               (t0)              
//    .sobel_data1       (sobel_data1)

   );

//assign judge_rgb=(post01_img_Bit)?24'hffffff:24'h0;

wire                        HV_o_hsync;
wire                        HV_o_vsync;
wire                        HV_o_de;
wire                        HV_dout;
// wire       [23:0]           HV_o_rgb;


HVcount_1#(
     .DW(24),
	  .IW(800)
      )HVcount(
    .pixelclk       (pixelclk),
    .reset_n        (reset_n),
    // .i_data         (rgb_0_p),
	 .i_vsync		(post01_frame_vsync),
	 .i_hsync		(post01_frame_href), 
	 .i_de   		(post01_frame_clken),
     .i_binary      (post01_img_Bit),	
    
     .hcount_l1     (hcount_l),
     .hcount_r1     (hcount_r),
     .vcount_l1     (vcount_l),
     .vcount_r1     (vcount_r),
    .hcount         (hcount_1),
    .vcount         (vcount_1),
 //   .o_data         (HV_o_rgb),
    .o_binary       (HV_dout),
    .o_hsync        (HV_o_hsync),
    .o_vsync        (HV_o_vsync),
    .o_de           (HV_o_de)
//	.o_hsync (judge_hsync) ,
//    .o_vsync(judge_vsync),                                                                                                  
//	.o_de   (judge_de   )   
    ); 
//assign judge_rgb=(HV_dout)?24'hffffff:24'h0;

Vertical_Projection#(
       .IMG_WIDTH_LINE (1024)
       )Vertical_Projection_inst(
       . pixelclk   (pixelclk) ,
	   . reset_n    (reset_n ) , 
       . en         (en) ,   
	   . i_binary   (HV_dout) ,
	   . i_hs       (HV_o_hsync) ,
	   . i_vs       (HV_o_vsync) ,
	   . i_de       (HV_o_de) ,       
       
	   . i_hcount   (hcount_1) ,
	   . i_vcount   (vcount_1) ,


      .hcount_l          (hcount_l1),
      .hcount_r          (hcount_r1),
      .vcount_l          (vcount_l1),
      .vcount_r          (vcount_r1)

		 );


wire  [7:0]        f1;
wire  [15:0]       a2;

	
feature_1   feature_inst 
(
      .pixelclk          (pixelclk),
      .rst_n             (reset_n),

	                                              
      .i_hs              (HV_o_hsync),
      .i_vs              (HV_o_vsync),
      .i_de              (HV_o_de),
     .hcount_l           (hcount_l1),
     .hcount_r           (hcount_r1),
     .vcount_l           (vcount_l1),
     .vcount_r           (vcount_r1),
     .a2                 (a2),	                     
     .f1                 (f1)
//      .t11               (t11),
//      .than              (r_t)
	                    
);

judge_features_1  judge_features(
         
       .pixelclk          (pixelclk  ),
	   .reset_n           (reset_n   ) ,
	   
  	   .i_rgb             (o_rgb_1) ,
	   .i_hsync           (HV_o_hsync) ,
	   .i_vsync           (HV_o_vsync)  ,
	   .i_de              (HV_o_de) ,
	   .f1                (f1),
       .a2                (a2),
//       .s0                (s0),
       .s1                (s1),
       .s2                (s2),
       .s3                (s3),
       .s4                (s4),
       .s5                (s5),
       .s6                (s6),
       .s7                (s7),
       .s8                (s8),
       .s9                (s9),
       .s10               (s10),
       .s11               (s11),
	   
       .sort              (sort),                                                               
       .o_rgb             (judge_rgb  ),
	   .o_hsync           (judge_hsync) ,
       .o_vsync           (judge_vsync),                                                                                                  
	   .o_de              (judge_de   )

 );




endmodule 