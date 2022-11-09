`timescale 1ns / 1ps

module HVcount_1#(
     parameter DW = 24,
	 parameter IW = 1920
      )(
    input                      pixelclk,
    input                      reset_n,
    input [DW-1:0]             i_data,
    input                      i_binary,    
    input                      i_hsync,
    input                      i_vsync,
    input                      i_de,
    input            [11:0]    hcount_l1,
    input            [11:0]    hcount_r1,
    input            [11:0]    vcount_l1,
    input            [11:0]    vcount_r1,
    

    output [11:0]              hcount,
    output [11:0]              vcount,
    output [DW-1:0]            o_data,
    output                     o_binary,
    output                     o_hsync,
    output                     o_vsync,
    output                     o_de
    );
    
reg [11:0]              hcount_r;
reg [11:0]              vcount_r;
reg [DW-1:0]            VGA_RGB_r;
reg                     VGA_binary_r;
reg                     vid_pVDE_r;
reg                     VGA_HS_r;
reg                     VGA_VS_r;
reg                     VGA_DE_r;

//synchronization
always @(posedge pixelclk) begin
  vid_pVDE_r <= i_de;
  VGA_RGB_r <= i_data;
  VGA_HS_r <= i_hsync;
  VGA_VS_r <= i_vsync;
  VGA_DE_r <= i_de;
end  


always@(posedge pixelclk or negedge reset_n)begin

    if(!reset_n) begin 
        hcount_r<=12'd0;
    end 
    else if (hcount_r==12'd1023)begin 
        hcount_r<=12'd0;
    end 
    else if(i_de==1'b1)begin 
        hcount_r<=hcount_r+1'b1;
    end 
    else begin 
        hcount_r<=12'd0;
    end 
end 


always@(posedge pixelclk or negedge reset_n)begin
    if(!reset_n) begin 
        vcount_r<=12'd0;
    end 
    else if ( hcount_r==12'd1023) begin
        if(vcount_r==12'd767 )begin 
            vcount_r<=12'd0;
        end 
        else begin 
            vcount_r<=vcount_r+1'b1;
        end 
     end
end 

always @(*)

 begin

   if (vcount_r>=vcount_l1+5 && vcount_r<=vcount_r1-5 &&  hcount_r>=hcount_l1+5 && hcount_r<=hcount_r1-12 )

    VGA_binary_r <= i_binary;

    else  VGA_binary_r <= 1'b0;
 
  end

 assign  o_data  =  (o_de)?VGA_RGB_r:0;
 assign  o_binary=  (o_de)?VGA_binary_r:0;
 assign  o_hsync =   VGA_HS_r;
 assign  o_vsync =   VGA_VS_r;
 assign  o_de    =   VGA_DE_r;
 assign  hcount  =   hcount_r;
 assign  vcount  =   vcount_r;
 
endmodule
