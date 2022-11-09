
module display(
        
       input						        pixelclk,
	   input                                reset_n,
       input                                en,

       input           [7:0]                t11,
  	   input          [23:0]                i_rgb,
	   input						        i_hsync,
	   input							    i_vsync,
	   input							    i_de,
	   
	   input            [11:0]             hcount,
       input            [11:0]             vcount,
       input            [3:0]	           number,                
	   input            [11:0]             hcount_l1,
       input            [11:0]             hcount_r1,
	   input            [11:0]             hcount_l2,
       input            [11:0]             hcount_r2,
	   input            [11:0]             hcount_l3,
       input            [11:0]             hcount_r3,
	   input            [11:0]             hcount_l4,
       input            [11:0]             hcount_r4,
//	   input            [11:0]             hcount_l5,
//       input            [11:0]             hcount_r5,
//	   input            [11:0]             hcount_l6,
//       input            [11:0]             hcount_r6,
//	   input            [11:0]             hcount_l7,
//       input            [11:0]             hcount_r7,
//	   input            [11:0]             hcount_l8,
//       input            [11:0]             hcount_r8,
                                           
       input            [11:0]             vcount_l1,
       input            [11:0]             vcount_r1,
       input            [11:0]             vcount_l2,
       input            [11:0]             vcount_r2,
       input            [11:0]             vcount_l3,
       input            [11:0]             vcount_r3,
       input            [11:0]             vcount_l4,
       input            [11:0]             vcount_r4,
//       input            [11:0]             vcount_l5,
//       input            [11:0]             vcount_r5,
//       input            [11:0]             vcount_l6,
//       input            [11:0]             vcount_r6,
//       input            [11:0]             vcount_l7,
//       input            [11:0]             vcount_r7,
//       input            [11:0]             vcount_l8,
//       input            [11:0]             vcount_r8,
//
//       input            [23:0]             r_t,
//       input            [7:0]              f1,
//       input            [23:0]             s0,
//       input            [23:0]             s1,
//       input            [23:0]             s2,
//       input            [23:0]             s3,
//       input            [23:0]             s4,
//       input            [23:0]             s5,
//       input            [23:0]             s6,
//       input            [23:0]             s7,
//       input            [23:0]             s8,
//       input            [23:0]             s9,
//       input            [23:0]             s10,
//       input            [23:0]             s11,
//       input            [3:0]              sort,
//       input            [3:0]              sort1,
//       input            [3:0]              sort2,
//       input            [3:0]              sort3,
	   
       output           [23:0]             o_rgb,
	   output							   o_hsync,
	   output							   o_vsync,                                                                                                  
	   output						       o_de




 );


reg[23:0]  i_rgb_r;
reg[23:0]  i_rgb_r1;


reg	   [23:0]             rgb_r;	
reg                       hsync_r;
reg                       vsync_r;
reg                       de_r;
//reg                       en1; 
//reg                       en2;
//reg                       en3;
//reg                       en4;
//reg                       en5; 


//always@(*)begin
//if(number==4'd0) begin 
// en1<=1'b0;
// en2<=1'b0;
// en3<=1'b0;
// en4<=1'b0;
// en5<=1'b0;
//
// end 
// else if(number==4'd1) begin 
// en1<=1'b1;
// en2<=1'b0;
// en3<=1'b0;
// en4<=1'b0;
// en5<=1'b0;
//
// end 
// else if(number==4'd2) begin 
// en1<=1'b1;
// en2<=1'b1;
// en3<=1'b0;
// en4<=1'b0;
// en5<=1'b0;
//
// end 
// else if(number==4'd3) begin 
// en1<=1'b1;
// en2<=1'b1;
// en3<=1'b1;
// en4<=1'b0;
// en5<=1'b0;
//
// end 
// else if(number==4'd4) begin 
// en1<=1'b1;
// en2<=1'b1;
// en3<=1'b1;
// en4<=1'b1;
// en5<=1'b0;
//
// end 
//
// else begin 
// en1<=en1;
// en2<=en2;
// en3<=en3;
// en4<=en4;
// en5<=en5;
//
// end 
//
//end 

//wire [7:0]              written_1;
//wire [7:0]              written_2;
//wire [7:0]              written_3;
//wire [7:0]              written_4;
//
//
//wire                    region_active_out_1;
//wire                    region_active_out_2;
//wire                    region_active_out_3;
//wire                    region_active_out_4;
//
//wire [11:0]             osd_x_1;
//wire [11:0]             osd_x_2;
//wire [11:0]             osd_x_3;
//wire [11:0]             osd_x_4;


// word_control word_control_inst_1(
//    .pixelclk          (pixelclk),
//	.reset_n           (reset_n ),
//	.i_vsync           (i_vsync), 
//	.hcount            (hcount),
//    .vcount            (vcount),       
//	.hcount_l1         (hcount_l1),
//    .hcount_r1         (hcount_r1),
//    .vcount_l1         (vcount_l1),
//    .vcount_r1         (vcount_r1),
//	.hcount_l2         (hcount_l2),
//    .hcount_r2         (hcount_r2),
//    .vcount_l2         (vcount_l2),
//    .vcount_r2         (vcount_r2),
//	.hcount_l3         (hcount_l3),
//    .hcount_r3         (hcount_r3),
//    .vcount_l3         (vcount_l3),
//    .vcount_r3         (vcount_r3),
//	.hcount_l4         (hcount_l4),
//    .hcount_r4         (hcount_r4),
//    .vcount_l4         (vcount_l4),
//    .vcount_r4         (vcount_r4),
//
////	.sort1             (sort),
////	.sort2             (sort1),
////	.sort3             (sort2),
////	.sort4             (sort3),
//
//	.en1               (en1),
//	.en2               (en2),
//	.en3               (en3),
//	.en4               (en4),
//
//   
//	 .written1           (written_1 ),
//	 .written2           (written_2 ),
//	 .written3           (written_3 ),
//	 .written4           (written_4 ),
//
//
//	 .region_active_out1 (region_active_out_1),
//	 .region_active_out2 (region_active_out_2),
//	 .region_active_out3 (region_active_out_3),
//	 .region_active_out4 (region_active_out_4),
//
//
//	 .osd_x1             (osd_x_1),
//	 .osd_x2             (osd_x_2),
//	 .osd_x3             (osd_x_3),
//	 .osd_x4             (osd_x_4)
//
//
// );
//

always @(posedge pixelclk) begin
  hsync_r <= i_hsync;
  vsync_r <= i_vsync;
  de_r    <= i_de;
  i_rgb_r <=i_rgb;
  i_rgb_r1 <=i_rgb_r; 


end

assign o_hsync = hsync_r;
assign o_vsync = vsync_r;
assign o_de    = i_de;
assign o_rgb   = rgb_r; 




always @(posedge pixelclk or negedge reset_n)

 begin

  if(!reset_n)
 
    rgb_r <= 24'h00000;

  else if (vcount>vcount_l1 && vcount<vcount_r1 && ( hcount==hcount_l1 || hcount==hcount_r1 ))

    rgb_r <= 24'h00ff00;

  else if (hcount > hcount_l1 && hcount < hcount_r1 && (vcount== vcount_l1 || vcount== vcount_r1 ))

    rgb_r <= 24'h00ff00;

  else if (vcount>vcount_l2 && vcount<vcount_r2 && ( hcount==hcount_l2 || hcount==hcount_r2 ))

    rgb_r <= 24'h00ff00;

  else if (hcount > hcount_l2 && hcount < hcount_r2 && (vcount== vcount_l2 || vcount== vcount_r2 ))

    rgb_r <= 24'h00ff00;

  else if (vcount>vcount_l3 && vcount<vcount_r3 && ( hcount==hcount_l3 || hcount==hcount_r3 ))

    rgb_r <= 24'h00ff00;

  else if (hcount > hcount_l3 && hcount < hcount_r3 && (vcount== vcount_l3 || vcount== vcount_r3 ))

    rgb_r <= 24'h00ff00;

  else if (vcount>vcount_l4 && vcount<vcount_r4 && ( hcount==hcount_l4 || hcount==hcount_r4 ))

    rgb_r <= 24'h00ff00;

  else if (hcount > hcount_l4 && hcount < hcount_r4 && (vcount== vcount_l4 || vcount== vcount_r4))

    rgb_r <= 24'h00ff00; 


// else  if(region_active_out_1== 1'b1)
//         begin 
//	           begin                     
//                    if(written_1[osd_x_1[2:0]] == 1'b1)
//			           rgb_r <= 24'hff0000;
//                  	  else
//			            rgb_r<= i_rgb_r1;
//                       end   
//	       end
//  else  if(region_active_out_2== 1'b1)
//         begin 
//	           begin                     
//                    if(written_2[osd_x_2[2:0]] == 1'b1)
//			           rgb_r <= 24'hff0000;
//                  	  else
//			            rgb_r<= i_rgb_r1;
//                       end   
//	       end
// else  if(region_active_out_3== 1'b1)
//         begin 
//	           begin                     
//                    if(written_3[osd_x_3[2:0]] == 1'b1)
//			           rgb_r <= 24'hff0000;
//                  	  else
//			            rgb_r<= i_rgb_r1;
//                       end   
//	       end

// else  if(region_active_out_4== 1'b1)
//         begin 
//	           begin                     
//                    if(written_4[osd_x_4[2:0]] == 1'b1)
//			           rgb_r <= 24'hff0000;
//                  	  else
//			            rgb_r<= i_rgb_r1;
//                       end   
//	       end

   
 else  rgb_r <=  i_rgb_r1;
     
 end



endmodule