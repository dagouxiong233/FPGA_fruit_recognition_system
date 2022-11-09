module ISP(

    input            pixelclk,
    input            clk,
    input            rstin   ,
    input    [23:0]  i_rgb   ,
    input            i_hsync ,
    input            i_vsync ,
    input            i_de    ,

    
    
    
    output           uart_tx,
    output   [23:0]  VGA_rgb ,
    output           VGA_hsync,
    output           VGA_vsync,
    output           VGA_de

   );


wire    [23:0]    o_rgb;
wire    [23:0]    o_ycbcr;
wire             o_hsync;
wire             o_vsync;
wire             o_de;
wire            en  ;

reg             en_1;
reg             en_2; 
reg             en_3;  
reg             en_4; 
reg             en_5;
reg             en_6;
reg             en_7;  
reg             en_8; 



reg        en_r;

  



rgb2ycbcr rgb2ycbcr(
    .pixelclk   (pixelclk),
	 .rst_n      (rstin) ,
    .i_rgb      (i_rgb),
    .i_hsync    (i_hsync),
    .i_vsync    (i_vsync),
    .i_de       (i_de),

  
    .o_rgb      (o_rgb),
    .o_ycbcr    (o_ycbcr),
    .o_hsync    (o_hsync),
    .o_vsync    (o_vsync),    
    .o_de0      (),                          
    .o_de       (o_de)                                                                                        
);

wire [23:0] o_binary_0 ;
wire [23:0] o_rgb_0    ;
wire [23:0] rgb_0_p    ;
wire        o_hsync_0 ;
wire        o_vsync_0  ;
wire        o_de_0     ;
wire        x0        ;

threshold_binary_0  threshold_binary_0_inst (
     .pixelclk   (pixelclk),
     .reset_n    (rstin) ,
     .i_ycbcr    (o_ycbcr) ,
     .i_rgb      (o_rgb) ,
     .i_hsync    (o_hsync) ,
     .i_vsync    (o_vsync) ,
     .i_de       (o_de) ,
     
//     .o_binary   (o_binary_0),
     .o_rgb      (o_rgb_0),
     .o_hsync    (o_hsync_0),
     .o_vsync    (o_vsync_0),   
     .x0         (x0) ,
     .o_de       (o_de_0)                                                                                        
);



Pretreatment   Pretreatment_inst(
        .pixelclk          (pixelclk),
        .rst_n             (rstin) ,
        .i_binary          (x0),
        .i_hs              (o_hsync_0), 
        .i_vs              (o_vsync_0),
        .i_de              (o_de_0)  ,
        .i_rgb_1           (o_rgb_0),


        .o_rgb_0_p         (rgb_0_p), 
        .en                (1'b1), 
        .post_frame_vsync  (post_frame_vsync_p),
        .post_frame_href   (post_frame_href_p ),	
        .post_frame_clken  (post_frame_clken_p),	
        .post_img_Bit      (post_img_Bit)

   );



wire       [11:0]           hcount;
wire       [11:0]           vcount;
                            
wire                        HV_o_hsync;
wire                        HV_o_vsync;
wire                        HV_o_de;
wire                        HV_dout;
wire       [23:0]           HV_o_rgb;
                            
reg        [11:0]           hcount_l;
reg        [11:0]           hcount_r;
reg        [11:0]           vcount_l;
reg        [11:0]           vcount_r;
                            


HVcount#(
     .DW(24),
	  .IW(1024)
      )HVcount(
    .pixelclk            (pixelclk),
    .reset_n             (rstin),
    .i_data              (rgb_0_p),
	.i_vsync		     (post_frame_vsync_p),
	.i_hsync		     (post_frame_href_p), 
	.i_de   		     (post_frame_clken_p),
    .i_binary            (post_img_Bit),	
    
    .hcount              (hcount),
    .vcount              (vcount),
    .o_data              (HV_o_rgb),
    .o_binary            (HV_dout),
    .o_hsync             (HV_o_hsync),
    .o_vsync             (HV_o_vsync),
    .o_de                (HV_o_de)

    );    

wire            [3:0]        h_pedge_cnt;
wire            [3:0]        h_nedge_cnt;
wire            [3:0]        v_pedge_cnt;
wire            [3:0]        v_nedge_cnt;
wire            [3:0]        number;

wire            [11:0]       hcount_l1;
wire            [11:0]       hcount_r1;
wire            [11:0]       hcount_l2;
wire            [11:0]       hcount_r2;
wire            [11:0]       hcount_l3;
wire            [11:0]       hcount_r3;
wire            [11:0]       hcount_l4;
wire            [11:0]       hcount_r4;
wire            [11:0]       hcount_l5;
wire            [11:0]       hcount_r5;
wire            [11:0]       hcount_l6;
wire            [11:0]       hcount_r6;
wire            [11:0]       hcount_l7;
wire            [11:0]       hcount_r7;
wire            [11:0]       hcount_l8;
wire            [11:0]       hcount_r8;

wire            [11:0]       vcount_l1;
wire            [11:0]       vcount_r1;
wire            [11:0]       vcount_l2;
wire            [11:0]       vcount_r2;
wire            [11:0]       vcount_l3;
wire            [11:0]       vcount_r3;
wire            [11:0]       vcount_l4;
wire            [11:0]       vcount_r4;
wire            [11:0]       vcount_l5;
wire            [11:0]       vcount_r5;

wire            [2:0]        vpframe_cnt;
	   
Vertical_Projection8#(
       .IMG_WIDTH_LINE(1024)
	   )U_Vertical_Projection8(
       .pixelclk      (pixelclk),
	    .reset_n       (rstin),    
	    .i_binary      (HV_dout),
	    .i_hs          (HV_o_hsync),
	    .i_vs          (HV_o_vsync),
	    .i_de          (HV_o_de), 	    
	    .i_hcount      (hcount),
	    .i_vcount      (vcount),
	    .frame_cnt     (vpframe_cnt),
        .h_pedge_cnt   (h_pedge_cnt),
        .h_nedge_cnt   (h_nedge_cnt),
        .v_pedge_cnt   (v_pedge_cnt),
        .v_nedge_cnt   (v_nedge_cnt),
	    .number        (number),

	    .hcount_l1    (hcount_l1),
        .hcount_r1    (hcount_r1),
	    .hcount_l2    (hcount_l2),
        .hcount_r2    (hcount_r2),
	    .hcount_l3    (hcount_l3),
        .hcount_r3    (hcount_r3),
	    .hcount_l4    (hcount_l4),
        .hcount_r4    (hcount_r4),
//	    .hcount_l5    (hcount_l5),
//        .hcount_r5    (hcount_r5),
//	    .hcount_l6    (hcount_l6),
//        .hcount_r6    (hcount_r6),
//	    .hcount_l7    (hcount_l7),
//        .hcount_r7    (hcount_r7),
//	    .hcount_l8    (hcount_l8),
//        .hcount_r8    (hcount_r8),

	   .vcount_l1     (vcount_l1),
       .vcount_r1     (vcount_r1),
	   .vcount_l2     (vcount_l2),
       .vcount_r2     (vcount_r2),
	   .vcount_l3     (vcount_l3),
       .vcount_r3     (vcount_r3),
	   .vcount_l4     (vcount_l4),
       .vcount_r4     (vcount_r4)
//	   .vcount_l5     (vcount_l5),
//       .vcount_r5     (vcount_r5)
//	   .vcount_l6     (vcount_l6),
//       .vcount_r6     (vcount_r6),
//	   .vcount_l7     (vcount_l7),
//       .vcount_r7     (vcount_r7),
//	   .vcount_l8     (vcount_l8),
//       .vcount_r8     (vcount_r8)

		); 


wire      [3:0]      sort;
wire      [11:0]     hcount_l11;
wire      [11:0]     hcount_r11;
wire      [11:0]     vcount_l11;
wire      [11:0]     vcount_r11;  

always@(posedge pixelclk )begin

 if(number==1'b0)begin

       en_1<=1'b0;
       en_2<=1'b0;
       en_3<=1'b0;
       en_4<=1'b0;
       en_5<=1'b0;


       end
    else if(number==1'b1)
      begin
       en_1<=1'b1;
       en_2<=1'b0;
       en_3<=1'b0;
       en_4<=1'b0;
       en_5<=1'b0;

      end
    else if(number==4'd2)
      begin
       en_1<=1'b1;
       en_2<=1'b1;
       en_3<=1'b0;
       en_4<=1'b0;
       en_5<=1'b0;

      end
    else if(number==4'd3)
      begin
       en_1<=1'b1;
       en_2<=1'b1;
       en_3<=1'b1;
       en_4<=1'b0;
       en_5<=1'b0;

      end

    else
 if(number==4'd4)
      begin
       en_1<=1'b1;
       en_2<=1'b1;
       en_3<=1'b1;
       en_4<=1'b1;
       en_5<=1'b0;

      end
    else if(number==4'd5)
      begin
       en_1<=1'b1;
       en_2<=1'b1;
       en_3<=1'b1;
       en_4<=1'b1;
       en_5<=1'b1;

      end


   else begin

       en_1<=1'b0;
       en_2<=1'b0;
       en_3<=1'b0;
       en_4<=1'b0;
       en_5<=1'b0;

       end

    end
// wire  [7:0]           t0; 
wire   [7:0]           r_t;            
judge_single  judge_single0_inst(

      .pixelclk           (pixelclk),
	  .reset_n            (rstin),  
                         
      .i_rgb              (HV_o_rgb),
	  .i_hsync            (HV_o_hsync) ,
	  .i_vsync            (HV_o_vsync) ,
	  .i_de               (HV_o_de) ,
      .en                 (en_1),                  
      .hcount             (hcount),
      .vcount             (vcount),
                          
      .hcount_l           (hcount_l1),
      .hcount_r           (hcount_r1),
      .vcount_l           (vcount_l1),
      .vcount_r           (vcount_r1),
	  
      .hcount_l1          (hcount_l11),
      .hcount_r1          (hcount_r11),
      .vcount_l1          (vcount_l11),
      .vcount_r1          (vcount_r11),
//      .t0                 (t0),
      .sort               (sort      )                    
//     .judge_rgb          (VGA_rgb   ),
//     .judge_hsync        (VGA_hsync ) ,
//     .judge_vsync        (VGA_vsync ),                                                                                                  
//     .judge_de           (VGA_de    )
);



wire      [3:0]      sort1;

wire      [11:0]     hcount_l22;
wire      [11:0]     hcount_r22;
wire      [11:0]     vcount_l22;
wire      [11:0]     vcount_r22;                 
                                  
judge_single  judge_single1_inst(
       .pixelclk           (pixelclk),
	    .reset_n           (rstin), 
                           
       .i_rgb              (HV_o_rgb),
       .i_hsync            (HV_o_hsync),
       .i_vsync            (HV_o_vsync),
       .i_de               (HV_o_de),
       .en                 (en_2), 
                           
	    .hcount             (hcount),
	    .vcount             (vcount),
                           
       .hcount_l           (hcount_l2 ),
       .hcount_r           (hcount_r2),
       .vcount_l           (vcount_l2),
       .vcount_r           (vcount_r2),

       .hcount_l1          (hcount_l22),
       .hcount_r1          (hcount_r22),
       .vcount_l1          (vcount_l22),
       .vcount_r1          (vcount_r22),
       .sort               (sort1),                        
       .judge_rgb          (o_rgb_s1), 
       .judge_hsync        (o_hsync_s1),
       .judge_vsync        (o_vsync_s1),                                                                                                  
       .judge_de           (o_de_s1   ) 
                                                                                    
	   );

wire      [3:0]      sort2;

wire      [11:0]     hcount_l33;
wire      [11:0]     hcount_r33;
wire      [11:0]     vcount_l33;
wire      [11:0]     vcount_r33;                 
                                  
judge_single  judge_single2_inst(
       .pixelclk           (pixelclk),
	    .reset_n           (rstin), 
                           
       .i_rgb              (HV_o_rgb),
       .i_hsync            (HV_o_hsync),
       .i_vsync            (HV_o_vsync),
       .i_de               (HV_o_de),
       .en                 (en_3),                            
	    .hcount            (hcount),
	    .vcount            (vcount),
                           
       .hcount_l           (hcount_l3),
       .hcount_r           (hcount_r3),
       .vcount_l           (vcount_l3),
       .vcount_r           (vcount_r3), 

       .hcount_l1          (hcount_l33),
       .hcount_r1          (hcount_r33),
       .vcount_l1          (vcount_l33),
       .vcount_r1          (vcount_r33),                        
       .sort               (sort2)                        
                                                                                        
	   );

wire      [3:0]      sort3;
wire      [11:0]     hcount_l44;
wire      [11:0]     hcount_r44;
wire      [11:0]     vcount_l44;
wire      [11:0]     vcount_r44;                 
                                  
judge_single_1  judge_single3_inst(
       .pixelclk           (pixelclk),
	    .reset_n            (rstin), 
                           
       .i_rgb              (HV_o_rgb),
       .i_hsync            (HV_o_hsync),
       .i_vsync            (HV_o_vsync),
       .i_de               (HV_o_de),
       .en                 (en_4),                            
	     .hcount            (hcount),
	     .vcount            (vcount),
                           
       .hcount_l           (hcount_l4),
       .hcount_r           (hcount_r4),
       .vcount_l           (vcount_l4),
       .vcount_r           (vcount_r4), 

       .hcount_l1          (hcount_l44),
       .hcount_r1          (hcount_r44),
       .vcount_l1          (vcount_l44),
       .vcount_r1          (vcount_r44),                        
       .sort               (sort3)                        
//       .judge_rgb          (o_rgb_s3),
//       .judge_hsync        (o_hsync_s3),
//       .judge_vsync        (o_vsync_s3),                                                                                                  
//       .judge_de           (o_de_s3 )                                                                                           
	   );
//	
//wire      [3:0]      sort4;
//wire      [23:0]     o_rgb_s4;
//wire                 o_hsync_s4;
//wire                 o_vsync_s4;
//wire                 o_de_s4   ; 
//wire      [11:0]     hcount_l55;
//wire      [11:0]     hcount_r55;
//wire      [11:0]     vcount_l55;
//wire      [11:0]     vcount_r55;                 
//                                  
//judge_single  judge_single4_inst(
//       .pixelclk           (pixelclk),
//	    .reset_n           (rstin), 
//                           
//       .i_rgb              (HV_o_rgb),
//       .i_hsync            (HV_o_hsync),
//       .i_vsync            (HV_o_vsync),
//       .i_de               (HV_o_de),
//       .en                 (en_5),                            
//	    .hcount            (hcount),
//	    .vcount            (vcount),
//                           
//       .hcount_l           (hcount_l5),
//       .hcount_r           (hcount_r5),
//       .vcount_l           (vcount_l5),
//       .vcount_r           (vcount_r5), 
//
//       .hcount_l1          (hcount_l55),
//       .hcount_r1          (hcount_r55),
//       .vcount_l1          (vcount_l55),
//       .vcount_r1          (vcount_r55),                        
//       .sort               (sort4)                        
////       .judge_rgb          (o_rgb_s4),
////       .judge_hsync        (o_hsync_s4),
////       .judge_vsync        (o_vsync_s4),                                                                                                  
////       .judge_de           (o_de_s4 )                                                                                           
//	   );
//


//
//display display(
//         
//       .pixelclk         (   pixelclk    ),
//	   .reset_n          (   rstin       ) ,
//       .en               (   1'b1    ) ,
//
//  	    .i_rgb             (HV_o_rgb) ,
//	    .i_hsync           (HV_o_hsync) ,
//	    .i_vsync           (HV_o_vsync)  ,
//	    .i_de              (HV_o_de) ,
//
////       .sort               (sort),
////       .sort1              (sort1),
////       .sort2              (sort2),
////       .sort3              (sort3),
//
//                        
//	   .hcount             (hcount) ,
//       .vcount             (vcount),
//	    .number            (number),                         
//
//	   .hcount_l1          (hcount_l11),
//       .hcount_r1          (hcount_r11),
//	   .hcount_l2          (hcount_l22),
//      .hcount_r2           (hcount_r22),
//	   .hcount_l3          (hcount_l33),
//      .hcount_r3           (hcount_r33),
//	   .hcount_l4          (hcount_l44),
//      .hcount_r4           (hcount_r44),
////	   .hcount_l5          (hcount_l5),
////      .hcount_r5           (hcount_r5),
////	   .hcount_l6          (hcount_l6),
////      .hcount_r6           (hcount_r6),
////	   .hcount_l7          (hcount_l7),
////      .hcount_r7           (hcount_r7),
////	   .hcount_l8          (hcount_l8),
////      .hcount_r8           (hcount_r8),
////
//      .vcount_l1           (vcount_l11),
//      .vcount_r1           (vcount_r11),
//      .vcount_l2           (vcount_l22),
//      .vcount_r2           (vcount_r22),
//      .vcount_l3           (vcount_l33),
//      .vcount_r3           (vcount_r33), 
//	  .vcount_l4           (vcount_l44),
//      .vcount_r4           (vcount_r44), 
////      .vcount_l5           (vcount_l5),
////      .vcount_r5           (vcount_r5),
////      .vcount_l6           (vcount_l6),
////      .vcount_r6           (vcount_r6),
////      .vcount_l7           (vcount_l7),
////      .vcount_r7           (vcount_r7), 
////	   .vcount_l8          (vcount_l8),
////      .vcount_r8           (vcount_r8),                      
//                                       
//      .o_rgb               (VGA_rgb),
//	  .o_hsync             (VGA_hsync) ,
//      .o_vsync             (VGA_vsync),                                                                                                  
//	  .o_de                (VGA_de   )
//
// );

wire        [7:0]                 number1;
wire        [7:0]                 number2;
wire        [7:0]                 number3;
wire        [3:0]                 ca1;
wire        [3:0]                 ca2;
wire        [3:0]                 ca3;

judge  judge_inst(
        .pixelclk        (pixelclk),
	    .rstin           (rstin) ,
        .sort            (sort),
        .sort1           (sort1 ),
        .sort2           (sort2),
        .sort3           (sort3),
        
        .number1         (number1),
        .number2         (number2),
        .number3         (number3),
        .ca1             (ca1),
        .ca2             (ca2),
        .ca3             (ca3 )


);


 




uart_test  uart_test(
     .sys_clk(clk ),
     .rst_n  (rstin ),
     .rx_data1 (number1),
     .rx_data2 (number2),
     .rx_data3 (number3),
     .sort1    (ca1),
     .sort2    (ca2),
     .sort3    (ca3),
     
     .uart_tx(uart_tx)
);






endmodule