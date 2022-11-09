module Bit_Erosion_Detector
#(
	parameter	[8:0]	IMG_HDISP = 10'd1024,	//1024*768
	parameter	[8:0]	IMG_VDISP = 10'd768
)

(
	//global clock
	input				clk,  				//cmos video pixel clock
	input				rst_n,				//global reset

	//Image data prepred to be processd
	input				per_frame_vsync,	//Prepared Image data vsync valid signal
	input				per_frame_href,		//Prepared Image data href vaild  signal
	input				per_frame_clken,	//Prepared Image data output/capture enable clock
	input			    per_img_Bit,		//Prepared Image Bit flag outout(1: Value, 0:inValid)
	
	//Image data has been processd
	output				post_frame_vsync,	//Processed Image data vsync valid signal
	output				post_frame_href,	//Processed Image data href vaild  signal
	output				post_frame_clken,	//Processed Image data output/capture enable clock
	output				post_img_Bit,		//Processed Image Bit flag outout(1: Value, 0:inValid)
    output [23:0]       post_img
);



wire			matrix_frame_vsync;	//Prepared Image data vsync valid signal
wire			matrix_frame_href;	//Prepared Image data href vaild  signal
wire			matrix_frame_clken;	//Prepared Image data output/capture enable clock	
wire			matrix_p11, matrix_p12, matrix_p13;	//3X3 Matrix output
wire			matrix_p21, matrix_p22, matrix_p23;
wire			matrix_p31, matrix_p32, matrix_p33;

Matrix_3X3  Matrixe_3X3_m0 (
    .clk(clk),                // input
    .matrix_frame_clken(matrix_frame_clken),    // output
    .matrix_frame_href(matrix_frame_href),    // output
    .matrix_frame_vsync(matrix_frame_vsync),    // output
    .rst_n(rst_n),            // input
    .per_frame_clken(per_frame_clken),      // input
    .per_frame_href(per_frame_href),      // input
    .per_frame_vsync(per_frame_vsync),      // input
    .matrix_p11(matrix_p11),  // output 
    .matrix_p12(matrix_p12),  // output 
    .matrix_p13(matrix_p13),  // output 
    .matrix_p21(matrix_p21),  // output 
    .matrix_p22(matrix_p22),  // output 
    .matrix_p23(matrix_p23),  // output 
    .matrix_p31(matrix_p31),  // output 
    .matrix_p32(matrix_p32),  // output 
    .matrix_p33(matrix_p33),  // output 
    .per_img_Bit(per_img_Bit)     // input[0:0]
);
//Add you arithmetic here
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//-------------------------------------------
//-------------------------------------------
//Eronsion Parameter
//      Original         Dilation			  Pixel
// [   0  0   0  ]   [   1	1   1 ]     [   P1  P2   P3 ]
// [   0  1   0  ]   [   1  1   1 ]     [   P4  P5   P6 ]
// [   0  0   0  ]   [   1  1	1 ]     [   P7  P8   P9 ]
//P = P1 & P2 & P3 & P4 & P5 & P6 & P7 & 8 & 9;
//---------------------------------------
//Eonsion with or operation
//Step1
reg	post_img_Bit1,	post_img_Bit2,	post_img_Bit3;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		post_img_Bit1 <= 1'b0;
		post_img_Bit2 <= 1'b0;
		post_img_Bit3 <= 1'b0;
		end
	else
		begin
		post_img_Bit1 <= matrix_p11 & matrix_p12 & matrix_p13;
		post_img_Bit2 <= matrix_p21 & matrix_p22 & matrix_p23;
		post_img_Bit3 <= matrix_p31 & matrix_p32 & matrix_p33;
		end
end

//Step 2
reg	post_img_Bit4;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		post_img_Bit4 <= 1'b0;
	else
		post_img_Bit4 <= post_img_Bit1 & post_img_Bit2 & post_img_Bit3;
end

//------------------------------------------
//lag 2 clocks signal sync  
reg	[7:0]	per_frame_vsync_r;
reg	[7:0]	per_frame_href_r;	
reg	[7:0]	per_frame_clken_r;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		per_frame_vsync_r <= 0;
		per_frame_href_r <= 0;
		per_frame_clken_r <= 0;
		end
	else
		begin
		per_frame_vsync_r 	<= 	{per_frame_vsync_r[6],per_frame_vsync_r[5],per_frame_vsync_r[4],per_frame_vsync_r[3],per_frame_vsync_r[2],per_frame_vsync_r[1],per_frame_vsync_r[0], matrix_frame_vsync};
		per_frame_href_r 	<= 	{per_frame_href_r[6] ,per_frame_href_r[5] ,per_frame_href_r[4] ,per_frame_href_r[3] ,per_frame_href_r[2] ,per_frame_href_r[1] ,per_frame_href_r[0] , matrix_frame_href };
		per_frame_clken_r 	<= 	{per_frame_clken_r[6],per_frame_clken_r[5],per_frame_clken_r[4],per_frame_clken_r[3],per_frame_clken_r[2],per_frame_clken_r[1],per_frame_clken_r[0], matrix_frame_clken};
		end
end
assign	post_frame_vsync 	= 	per_frame_vsync_r[7];
assign	post_frame_href 	= 	per_frame_href_r [7];
assign	post_frame_clken 	= 	per_frame_clken_r[7];
assign	post_img_Bit		=	post_frame_href ? post_img_Bit4 : 1'b0;
assign  post_img=post_img_Bit?24'h00:24'hffffff;
endmodule