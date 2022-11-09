module word_control(
      input						         pixelclk,
	  input                                reset_n,
	  input                                i_vsync, 
	  input            [11:0]              hcount,
      input            [11:0]              vcount,       
	  input            [11:0]             hcount_l1,
      input            [11:0]             hcount_r1,
      input            [11:0]             vcount_l1,
      input            [11:0]             vcount_r1,
      input            [11:0]             hcount_l2, 
      input            [11:0]             hcount_r2,
      input            [11:0]             vcount_l2,
      input            [11:0]             vcount_r2,
      input            [11:0]             hcount_l3, 
      input            [11:0]             hcount_r3,
      input            [11:0]             vcount_l3,
      input            [11:0]             vcount_r3,
      input            [11:0]             hcount_l4, 
      input            [11:0]             hcount_r4,
      input            [11:0]             vcount_l4,
      input            [11:0]             vcount_r4,
	   input            [3:0]              sort1,
	   input            [3:0]              sort2,
	   input            [3:0]              sort3,
	   input            [3:0]              sort4,

	   input                               en1,
	   input                               en2,
	   input                               en3,
	   input                               en4,


	   output        reg   [7:0]              written1,
	   output        reg   [7:0]              written2,
	   output        reg   [7:0]              written3,
	   output        reg   [7:0]              written4,


	   output                              region_active_out,
	   output                              region_active_out1,
	   output                              region_active_out2,
	   output                              region_active_out3,
	   output                              region_active_out4,


      output           [11:0]             osd_x1,
      output           [11:0]             osd_x2,
      output           [11:0]             osd_x3,
      output           [11:0]             osd_x4


);
parameter OSD_WIDTH   =  12'd144;
parameter OSD_HEGIHT  =  12'd28;


 
reg         [15:0]          osd_ram_addr;
wire        [15:0]          osd_ram_addr1;
wire        [15:0]          osd_ram_addr2;
wire        [15:0]          osd_ram_addr3;
wire        [15:0]          osd_ram_addr4;


wire        [7:0]          q;
wire        [7:0]          q1;
wire        [7:0]          q2;
wire        [7:0]          q3;
wire        [7:0]          q4;
wire        [7:0]          q5;
wire        [7:0]          q6;
wire        [7:0]          q7;
wire        [7:0]          q8;
wire        [7:0]          q9;
wire        [7:0]          q10;
wire        [7:0]          q11;
wire        [7:0]          q12;


// written_enable  written_enable1_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l1),
//        . hcount_r1            (hcount_r1),
//        . vcount_l1            (vcount_l1),
//        . vcount_r1            (vcount_r1),           
//        .en                    (en1),
//        . osd_ram_addr         (osd_ram_addr1),
////        . written              (written ),
//        . region_active_out    (region_active_out1),
//        . osd_x                (osd_x1)
//	   
//);
//
//
// written_enable  written_enable2_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l2),
//        . hcount_r1            (hcount_r2),
//        . vcount_l1            (vcount_l2),
//        . vcount_r1            (vcount_r2),           
//        .en                    (en2),                               
//        . osd_ram_addr         (osd_ram_addr2),
////        . written              (written ),
//        . region_active_out    (region_active_out2),
//        . osd_x                (osd_x2)
//	   
//);
//
// written_enable  written_enable3_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l3),
//        . hcount_r1            (hcount_r3),
//        . vcount_l1            (vcount_l3),
//        . vcount_r1            (vcount_r3),           
//        .en                    (en3),                               
//        . osd_ram_addr         (osd_ram_addr3),
////        . written              (written ),
//        . region_active_out    (region_active_out3),
//        . osd_x                (osd_x3)
//	   
//);

// written_enable  written_enable4_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l4),
//        . hcount_r1            (hcount_r4),
//        . vcount_l1            (vcount_l4),
//        . vcount_r1            (vcount_r4),           
//        .en                    (en4),                               
//        . osd_ram_addr         (osd_ram_addr4),
////        . written              (written ),
//        . region_active_out    (region_active_out4),
//        . osd_x                (osd_x4)
//	   
//);

// written_enable  written_enable5_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l5),
//        . hcount_r1            (hcount_r5),
//        . vcount_l1            (vcount_l5),
//        . vcount_r1            (vcount_r5),           
//        .en                    (en5),                               
//        . osd_ram_addr         (osd_ram_addr5),
////        . written              (written ),
//        . region_active_out    (region_active_out5),
//        . osd_x                (osd_x5)
//	   
//);
//
// written_enable  written_enable6_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l6),
//        . hcount_r1            (hcount_r6),
//        . vcount_l1            (vcount_l6),
//        . vcount_r1            (vcount_r6),           
//        .en                    (en6),                               
//        . osd_ram_addr         (osd_ram_addr6),
////        . written              (written ),
//        . region_active_out    (region_active_out6),
//        . osd_x                (osd_x6)
//	   
//);
//
// written_enable  written_enable7_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l7),
//        . hcount_r1            (hcount_r7),
//        . vcount_l1            (vcount_l7),
//        . vcount_r1            (vcount_r7),           
//        .en                    (en7),                               
//        . osd_ram_addr         (osd_ram_addr7),
////        . written              (written ),
//        . region_active_out    (region_active_out7),
//        . osd_x                (osd_x7)
//	   
//);
//
//written_enable  written_enable8_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l8),
//        . hcount_r1            (hcount_r8),
//        . vcount_l1            (vcount_l8),
//        . vcount_r1            (vcount_r8),           
//        .en                    (en8),                               
//        . osd_ram_addr         (osd_ram_addr8),
////        . written              (written ),
//        . region_active_out    (region_active_out8),
//        . osd_x                (osd_x8)
//	   
//);

//written_enable  written_enable9_inst
//
//(
//        . pixelclk             (pixelclk),
//        . reset_n              (reset_n ),
//        . i_vsync              (i_vsync ), 
//        . hcount               (hcount),
//        . vcount               (vcount),       
//        . hcount_l1            (hcount_l9),
//        . hcount_r1            (hcount_r9),
//        . vcount_l1            (vcount_l9),
//        . vcount_r1            (vcount_r9),           
//        .en                    (en9),                               
//        . osd_ram_addr         (osd_ram_addr9),
////        . written              (written ),
//        . region_active_out    (region_active_out9),
//        . osd_x                (osd_x9)
//	   
//);

//always@(*)
//  begin
//        if(region_active_out1 == 1'b1)
//
//    		osd_ram_addr <= osd_ram_addr1 ;
//
//      else if(region_active_out2 == 1'b1)
//
//    		osd_ram_addr <= osd_ram_addr2 ;
//
//      else if(region_active_out3 == 1'b1)
//
//    		osd_ram_addr <= osd_ram_addr3 ;
////
////      else if(region_active_out4 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr4 ;
//
////      else if(region_active_out5 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr5 ;
//
////      else if(region_active_out6 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr6 ;
////
////      else if(region_active_out7 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr7 ;
////
////      else if(region_active_out8 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr8 ;
////
////      else if(region_active_out9 == 1'b1)
////
////    		osd_ram_addr <= osd_ram_addr9 ;
//
//    else      osd_ram_addr <= 16'd0;
//
//
//
//   end
//
//always@(*)
//  begin
//    if(sort1==4'd1) 
//    written1<=q;
//	else    if(sort1==4'd2) 
//    written1<=q1;
//	else    if(sort1==4'd3) 
//    written1<=q2;
//    else    if(sort1==4'd4) 
//    written1<=q3;
//    else    if(sort1==4'd5) 
//    written1<=q4;
//	else    if(sort1==4'd6) 
//    written1<=q5;
//	else    if(sort1==4'd7) 
//    written1<=q6;
//    else    if(sort1==4'd8) 
//    written1<=q7;
//	else    if(sort1==4'd9) 
//    written1<=q8;
//	else    if(sort1==4'd10) 
//    written1<=q9;
//    else    if(sort1==4'd11) 
//    written1<=q10;
//    else    if(sort1==4'd12) 
//    written1<=q11;	
//    else    if(sort1==4'd13) 
//    written1<=q12;
//	else  
//    written1<= written1;			
//	end 
//
//always@(*)
//  begin
//    if(sort2==4'd1) 
//    written2<=q;
//	else    if(sort2==4'd2) 
//    written2<=q1;
//	else    if(sort2==4'd3) 
//    written2<=q2;
//    else    if(sort2==4'd4) 
//    written2<=q3;
//    else    if(sort2==4'd5) 
//    written2<=q4;
//	else    if(sort2==4'd6) 
//    written2<=q5;
//	else    if(sort2==4'd7) 
//    written2<=q6;
//    else    if(sort2==4'd8) 
//    written2<=q7;
//	else    if(sort2==4'd9) 
//    written2<=q8;
//	else    if(sort2==4'd10) 
//    written2<=q9;
//    else    if(sort2==4'd11) 
//    written2<=q10;
//    else    if(sort2==4'd12) 
//    written2<=q11;	
//    else    if(sort2==4'd13) 
//    written2<=q12;
//	else  
//    written2<= written2;	
//		
//	end 
//
//always@(*)
//  begin
//    if(sort3==4'd1) 
//    written3<=q;
//	else    if(sort3==4'd2) 
//    written3<=q1;
//	else    if(sort3==4'd3) 
//    written3<=q2;
//    else    if(sort3==4'd4) 
//    written3<=q3;
//    else    if(sort3==4'd5) 
//    written3<=q4;
//	else    if(sort3==4'd6) 
//    written3<=q5;
//	else    if(sort3==4'd7) 
//    written3<=q6;
//    else    if(sort3==4'd8) 
//    written3<=q7;
//	else    if(sort3==4'd9) 
//    written3<=q8;
//	else    if(sort3==4'd10) 
//    written3<=q9;
//    else    if(sort3==4'd11) 
//    written3<=q10;
//    else    if(sort3==4'd12) 
//    written3<=q11;	
//    else    if(sort3==4'd13) 
//    written3<=q12;	
//	else  
//    written3<= written3;	
//		
//	end 

//always@(*)
//  begin
//    if(sort4==4'd1) 
//    written4<=q;
//	else    if(sort4==4'd2) 
//    written4<=q1;
//	else    if(sort4==4'd3) 
//    written4<=q2;
//    else    if(sort4==4'd4) 
//    written4<=q3;
//    else    if(sort4==4'd5) 
//    written4<=q4;
//	else    if(sort4==4'd6) 
//    written4<=q5;
//	else    if(sort4==4'd7) 
//    written4<=q6;
//    else    if(sort4==4'd8) 
//    written4<=q7;
//	else    if(sort4==4'd9) 
//    written4<=q8;
//	else    if(sort4==4'd10) 
//    written4<=q9;
//    else    if(sort4==4'd11) 
//    written4<=q10;
//    else    if(sort4==4'd12) 
//    written4<=q11;	
//    else    if(sort4==4'd13) 
//    written4<=q12;	
//	else  
//    written4<= written4;	
//		
//	end 

//always@(*)
//  begin
//    if(sort5==4'd0) 
//    written5<=q;
//	else    if(sort5==4'd1) 
//    written5<=q1;
//	else    if(sort5==4'd2) 
//    written5<=q2;
//    else    if(sort5==4'd3) 
//    written5<=q3;
//    else    if(sort5==4'd4) 
//    written5<=q4;
//	else    if(sort5==4'd5) 
//    written5<=q5;
//	else    if(sort5==4'd6) 
//    written5<=q6;
//    else    if(sort5==4'd7) 
//    written5<=q7;
//	else    if(sort5==4'd8) 
//    written5<=q8;
//	else    if(sort5==4'd9) 
//    written5<=q9;
//    else    if(sort5==4'd10) 
//    written5<=q10;
//    else    if(sort5==4'd11) 
//    written5<=q11;	
//    else    if(sort5==4'd12) 
//    written5<=q12;	
//	else  
//    written5<= written5;	
//		
//	end 
//
//always@(*)
//  begin
//    if(sort6==4'd0) 
//    written6<=q;
//	else    if(sort6==4'd1) 
//    written6<=q1;
//	else    if(sort6==4'd2) 
//    written6<=q2;
//    else    if(sort6==4'd3) 
//    written6<=q3;
//    else    if(sort6==4'd4) 
//    written6<=q4;
//	else    if(sort6==4'd6) 
//    written6<=q6;
//	else    if(sort6==4'd5) 
//    written6<=q5;
//    else    if(sort6==4'd7) 
//    written6<=q7;
//	else    if(sort6==4'd8) 
//    written6<=q8;
//	else    if(sort6==4'd9) 
//    written6<=q9;
//    else    if(sort6==4'd10) 
//    written6<=q10;
//    else    if(sort6==4'd11) 
//    written6<=q11;	
//	else  
//    written6<= written6;	
//		
//	end 
//
//always@(*)
//  begin
//    if(sort7==4'd0) 
//    written7<=q;
//	else    if(sort7==4'd1) 
//    written7<=q1;
//	else    if(sort7==4'd2) 
//    written7<=q2;
//    else    if(sort7==4'd3) 
//    written7<=q3;
//    else    if(sort7==4'd4) 
//    written7<=q4;
//	else    if(sort7==4'd5) 
//    written7<=q5;
//	else    if(sort7==4'd6) 
//    written7<=q6;
//    else    if(sort7==4'd7) 
//    written7<=q7;
//	else    if(sort7==4'd8) 
//    written7<=q8;
//	else    if(sort7==4'd9) 
//    written7<=q9;
//    else    if(sort7==4'd10) 
//    written7<=q10;
//    else    if(sort7==4'd11) 
//    written7<=q11;	
//	else  
//    written7<= written7;	
//		
//	end 
//
//always@(*)
//  begin
//    if(sort8==4'd0) 
//    written8<=q;
//	else    if(sort8==4'd1) 
//    written8<=q1;
//	else    if(sort8==4'd2) 
//    written8<=q2;
//    else    if(sort8==4'd3) 
//    written8<=q3;
//    else    if(sort8==4'd4) 
//    written8<=q4;
//	else    if(sort8==4'd5) 
//    written8<=q5;
//	else    if(sort8==4'd6) 
//    written8<=q6;
//    else    if(sort8==4'd7) 
//    written8<=q7;
//	else    if(sort8==4'd8) 
//    written8<=q8;
//	else    if(sort8==4'd9) 
//    written8<=q9;
//    else    if(sort8==4'd10) 
//    written8<=q10;
//    else    if(sort8==4'd11) 
//    written8<=q11;	
//	else  
//    written8<= written8;	
//		
//	end 
//
//always@(*)
//  begin
//    if(sort9==4'd0) 
//    written9<=q;
//	else    if(sort9==4'd1) 
//    written9<=q1;
//	else    if(sort9==4'd2) 
//    written9<=q2;
//    else    if(sort9==4'd3) 
//    written9<=q3;
//    else    if(sort9==4'd4) 
//    written9<=q4;
//	else    if(sort9==4'd5) 
//    written9<=q5;
//	else    if(sort9==4'd6) 
//    written9<=q6;
//    else    if(sort9==4'd7) 
//    written9<=q7;
//	else    if(sort9==4'd8) 
//    written9<=q8;
//	else    if(sort9==4'd9) 
//    written9<=q9;
//    else    if(sort9==4'd10) 
//    written9<=q10;
//    else    if(sort9==4'd11) 
//    written9<=q11;	
//	else  
//    written9<= written9;	
//		
//	end 
//
//apple_rom   apple_rom_m0 (
//    .addr(osd_ram_addr[15:3]),
//    .clk(pixelclk ),
//    .rst(1'b0),
//    .rd_data(q)
//            
//);
//orange_rom  orange_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q1)     // output [7:0]
//);
//
//pear_rom  pear_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q2)     // output [7:0]
//);
//
//
////火龙果
//mango_rom  mango_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q3)     // output [7:0]
//);
//
////黄芒果
//mango1  mango1_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q6)     // output [7:0]
//);
//
////绿色芒果
//mango2  mango2_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q7)     // output [7:0]
//);
//
//banna_rom  bannaa_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q4)     // output [7:0]
//);
//
//grape_rom  grape_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q5)     // output [7:0]
//);
//
//kkkk kkkk_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q8)     // output [7:0]
//);
//
//green_apple green_apple_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q9)     // output [7:0]
//);
//
//Mangosteen_rom  Mangosteen_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q10)     // output [7:0]
//);
//
//Green_pear_room   Green_pear_room_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q11)     // output [7:0]
//);
//
//Fig_rom   Fig_rom_name (
//  .addr(osd_ram_addr[15:3]),          // input [10:0]
//  .clk(pixelclk),            // input
//  .rst(1'b0),            // input
//  .rd_data(q12)     // output [7:0]
//);
endmodule