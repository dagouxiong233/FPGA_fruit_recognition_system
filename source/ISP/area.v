module area(
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
output    reg           hs_r,
output    reg           vs_r,
output    reg           de_r,
output    wire			post_frame_vsync,
output    wire			post_frame_href,	
output    wire			post_frame_clken,	
output    wire			post_img_Bit,
output    wire          sobel_vs,
output    wire          sobel_de,
output    wire          sobel_hs,
output    wire          sobel_data
//output    wire    [23:0] sobel_data1,
//output    reg     [7:0]       t1,	
//output    reg     [23:0]       l1,
//output    reg     [23:0]       s0


   );

                
reg              post0_1frame_vsync_r;
wire			 post0_1frame_vsync;	//Processed Image data vsync valid signal
wire			 post0_1frame_href;	//Processed Image data href vaild  signal
wire			 post0_1frame_clken;	//Processed Image data output/capture enable clock
wire			 post0_1img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)

 wire     [23:0] o_rgb_0_r;
 assign   post_frame_vsync=post0_1frame_vsync ;  
 assign   post_frame_href =post0_1frame_href  ;	 
 assign   post_frame_clken= post0_1frame_clken ;	 
 assign   post_img_Bit =post0_1img_Bit ;  

wire			post0_frame_vsync;	//Processed Image data vsync valid signal
wire			post0_frame_href;	//Processed Image data href vaild  signal
wire			post0_frame_clken;	//Processed Image data output/capture enable clock
wire			post0_img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)


Bit_Erosion_Detector  Bit_Erosion_Detector_x0inst  

(
	//global clock
	.clk					(pixelclk),  				//cmos video pixel clock
	.rst_n					(rst_n),				//global reset

	//Image data prepred to be processd
	.per_frame_vsync		(i_vs),	//Prepared Image data vsync valid signal
	.per_frame_href			(i_hs),		//Prepared Image data href vaild  signal
	.per_frame_clken		(i_de),	//Prepared Image data output/capture enable clock
	.per_img_Bit			(i_binary),		//Processed Image Bit flag outout(1: Value, 0:inValid)
                                               //Image data has been processd
	.post_frame_vsync		(post0_frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post0_frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post0_frame_clken),		//Processed Image data output/capture enable clock
	.post_img_Bit			(post0_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
);

//wire			post0_1frame_vsync;	//Processed Image data vsync valid signal
//wire			post0_1frame_href;	//Processed Image data href vaild  signal
//wire			post0_1frame_clken;	//Processed Image data output/capture enable clock
//wire			post0_1img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)


Bit_Dilation_Detector  Bit_Dilation_Detector_x1inst 
(
	//global clock
	.clk					(pixelclk),  				//cmos video pixel clock
	.rst_n					(rst_n),				//global reset

	//Image data prepred to be processd
	.per_frame_vsync		(post0_frame_vsync),	//Prepared Image data vsync valid signal
	.per_frame_href			(post0_frame_href),		//Prepared Image data href vaild  signal
	.per_frame_clken		(post0_frame_clken),	//Prepared Image data output/capture enable clock
	.per_img_Bit			(post0_img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)

                                               //Image data has been processd
	.post_frame_vsync		(post0_1frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post0_1frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post0_1frame_clken),		//Processed Image data output/capture enable clock
	.post_img_Bit			(post0_1img_Bit),			//Processed Image Bit flag outout(1: Value, 0:inValid)
    .post_img               (post_img)
);

//assign  post0_img_Bit1=post0_frame_clken?post0_img_Bit:1'b0;
//assign  post0_img_Bit2=post0_img_Bit1?24'hffffff:24'h00;
//assign  post0_img_Bit1=post0_img_Bit?24'hffffff:24'h00;
//
//wire			post01_frame_vsync;	//Processed Image data vsync valid signal
//wire			post01_frame_href;	//Processed Image data href vaild  signal
//wire			post01_frame_clken;	//Processed Image data output/capture enable clock
//wire			post01_img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)
//
//Bit_Erosion_Detector    Bit_Erosion_Detector_x0_inst  
//
//(
//	//global clock
//	.clk					(pixelclk),  				//cmos video pixel clock
//	.rst_n					(rst_n),				//global reset
//
//	//Image data prepred to be processd
//	.per_frame_vsync		(post0_1frame_vsync),	//Prepared Image data vsync valid signal
//	.per_frame_href			(post0_1frame_href),		//Prepared Image data href vaild  signal
//	.per_frame_clken		(post0_1frame_clken),	//Prepared Image data output/capture enable clock
//	.per_img_Bit			(post0_1img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)
//                                               //Image data has been processd
//	.post_frame_vsync		(post01_frame_vsync),		//Processed Image data vsync valid signal
//	.post_frame_href		(post01_frame_href),		//Processed Image data href vaild  signal
//	.post_frame_clken		(post01_frame_clken),		//Processed Image data output/capture enable clock
//	.post_img_Bit			(post01_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
//  //  .post_img               (post_img)
//);
//
//
//
//Bit_Dilation_Detector  Bit_Dilation_Detectorx1_inst  
//
//(
//	//global clock
//	.clk					(pixelclk),  				//cmos video pixel clock
//	.rst_n					(rst_n),				//global reset
//
//	//Image data prepred to be processd
//	.per_frame_vsync		(post01_frame_vsync),	//Prepared Image data vsync valid signal
//	.per_frame_href			(post01_frame_href),		//Prepared Image data href vaild  signal
//	.per_frame_clken		(post01_frame_clken),	//Prepared Image data output/capture enable clock
//	.per_img_Bit			(post01_img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)
//                                               //Image data has been processd
//	.post_frame_vsync		(post02_frame_vsync),		//Processed Image data vsync valid signal
//	.post_frame_href		(post02_frame_href),		//Processed Image data href vaild  signal
//	.post_frame_clken		(post02_frame_clken),		//Processed Image data output/capture enable clock
//	.post_img_Bit			(post02_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
// //   .post_img               (post_img)
//);
	 	
	

 
endmodule