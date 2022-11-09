module Pretreatment(
input					pixelclk,
input                   rst_n,
input                   en,
input                   i_binary,
input					i_hs,
input					i_vs,
input					i_de,
input     [23:0]        i_rgb_1,

output    [23:0]        o_rgb_0_p,
output    wire			post_frame_vsync,
output    wire			post_frame_href,	
output    wire			post_frame_clken,	
output    wire			post_img_Bit

   );



wire			post02_frame_vsync;
wire			post02_frame_href ;	
wire			post02_frame_clken;	
wire			post02_img_Bit    ;  
wire			post0_frame_vsync;	//Processed Image data vsync valid signal
wire			post0_frame_href;	//Processed Image data href vaild  signal
wire			post0_frame_clken;	//Processed Image data output/capture enable clock
wire			post0_img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)
wire     [23:0] o_rgb_0_r;
 assign   post_frame_vsync=post02_frame_vsync ;  
 assign   post_frame_href =post02_frame_href  ;	 
 assign   post_frame_clken= post02_frame_clken ;	 
 assign   post_img_Bit =post02_img_Bit ;  
 assign   o_rgb_0_p=o_rgb_0_r;

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

wire			post01_frame_vsync;	//Processed Image data vsync valid signal
wire			post01_frame_href;	//Processed Image data href vaild  signal
wire			post01_frame_clken;	//Processed Image data output/capture enable clock
wire			post01_img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)


Bit_Erosion_Detector  Bit_Erosion_Detector_x1inst 
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
	.post_frame_vsync		(post01_frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post01_frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post01_frame_clken),		//Processed Image data output/capture enable clock
	.post_img_Bit			(post01_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
);


//assign  post0_img_Bit1=post0_img_Bit?24'hffffff:24'h00;

//wire			post01_frame_vsync;	//Processed Image data vsync valid signal
//wire			post01_frame_href;	//Processed Image data href vaild  signal
//wire			post01_frame_clken;	//Processed Image data output/capture enable clock
//wire			post01_img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)
//
//Bit_Erosion_Detector  Bit_Erosion_Detector_x2_inst  
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

//wire			post0_2frame_vsync;	//Processed Image data vsync valid signal
//wire			post0_2frame_href;	//Processed Image data href vaild  signal
//wire			post0_2frame_clken;	//Processed Image data output/capture enable clock
//wire			post0_2img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)

Bit_Dilation_Detector  Bit_Dilation_Detector_x3_inst  

(
	//global clock
	.clk					(pixelclk),  				//cmos video pixel clock
	.rst_n					(rst_n),				//global reset

	//Image data prepred to be processd
	.per_frame_vsync		(post01_frame_vsync),	//Prepared Image data vsync valid signal
	.per_frame_href			(post01_frame_href),		//Prepared Image data href vaild  signal
	.per_frame_clken		(post01_frame_clken),	//Prepared Image data output/capture enable clock
	.per_img_Bit			(post01_img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)
                                               //Image data has been processd
	.post_frame_vsync		(post02_frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post02_frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post02_frame_clken),		//Processed Image data output/capture enable clock
	.post_img_Bit			(post02_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
  //  .post_img               (post_img)
);

//
//wire			post0_3frame_vsync;	//Processed Image data vsync valid signal
//wire			post0_3frame_href;	//Processed Image data href vaild  signal
//wire			post0_3frame_clken;	//Processed Image data output/capture enable clock
//wire			post0_3img_Bit;		//Processed Image Bit flag outout(1: Value, 0:inValid)
//
//Bit_Dilation_Detector  Bit_Dilation_Detector_x1_inst  
//
//(
//	//global clock
//	.clk					(pixelclk),  				//cmos video pixel clock
//	.rst_n					(rst_n),				//global reset
//
//	//Image data prepred to be processd
//	.per_frame_vsync		(post0_2frame_vsync),	//Prepared Image data vsync valid signal
//	.per_frame_href			(post0_2frame_href),		//Prepared Image data href vaild  signal
//	.per_frame_clken		(post0_2frame_clken),	//Prepared Image data output/capture enable clock
//	.per_img_Bit			(post0_2img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)
//                                               //Image data has been processd
//	.post_frame_vsync		(post02_frame_vsync),		//Processed Image data vsync valid signal
//	.post_frame_href		(post02_frame_href),		//Processed Image data href vaild  signal
//	.post_frame_clken		(post02_frame_clken),		//Processed Image data output/capture enable clock
//	.post_img_Bit			(post02_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
//  //  .post_img               (post_img)
//);


//Bit_Dilation_Detector  Bit_Dilation_Detector_x2_inst  
//
//(
//	//global clock
//	.clk					(pixelclk),  				//cmos video pixel clock
//	.rst_n					(rst_n),				//global reset
//
//	//Image data prepred to be processd
//	.per_frame_vsync		(post0_3frame_vsync),	//Prepared Image data vsync valid signal
//	.per_frame_href			(post0_3frame_href),		//Prepared Image data href vaild  signal
//	.per_frame_clken		(post0_3frame_clken),	//Prepared Image data output/capture enable clock
//	.per_img_Bit			(post0_3img_Bit),		//Processed Image Bit flag outout(1: Value, 0:inValid)
//                                               //Image data has been processd
//	.post_frame_vsync		(post02_frame_vsync),		//Processed Image data vsync valid signal
//	.post_frame_href		(post02_frame_href),		//Processed Image data href vaild  signal
//	.post_frame_clken		(post02_frame_clken),		//Processed Image data output/capture enable clock
//	.post_img_Bit			(post02_img_Bit)			//Processed Image Bit flag outout(1: Value, 0:inValid)
// //   .post_img               (post_img)
//);

delay_0   delay_0_inst(
    .pixelclk    (pixelclk), 
    .rst_n       (rst_n),
//    .en          (1'b1),
    .i_rgb_1     (i_rgb_1),
                 
    .o_rgb_0_r   (o_rgb_0_r)
   );


   	 
endmodule