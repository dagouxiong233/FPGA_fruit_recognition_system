
module written_enable
#(
        parameter OSD_WIDTH   =  12'd144,
        parameter OSD_HEGIHT  =  12'd28
)
(
	   input						       pixelclk,
	   input                               reset_n,
	   input                               i_vsync, 
	   input            [11:0]             hcount,
       input            [11:0]             vcount,       
	   input            [11:0]             hcount_l1,
       input            [11:0]             hcount_r1,
       input            [11:0]             vcount_l1,
       input            [11:0]             vcount_r1,            
	   input                               en,
	   output           [15:0]             osd_ram_addr,
	   output                              region_active_out,
	   output           [11:0]             osd_x
	   
);


    reg           region_active;
    reg           region_active_d0;
    reg           region_active_d1;
    reg           region_active_d2;
    reg  [11:0]   osd_x1;

    reg  [15:0]  osd_ram_addr1;
    reg        i_vsync_d0;
    reg        i_vsync_d1;
    
    assign     osd_x=osd_x1;

    assign     osd_ram_addr=osd_ram_addr1;
    assign     region_active_out=region_active_d0;
    
    always@(posedge pixelclk)
    begin
    	if(vcount >= vcount_l1 - OSD_HEGIHT  && vcount <= vcount_l1+ 12'd1  && hcount  >= hcount_l1 && hcount  <= hcount_l1 + OSD_WIDTH - 12'd1)
    		region_active <= 1'b1;
    	else
    		region_active <= 1'b0;
    end
    
    
    always@(posedge pixelclk)
    begin
    if (en==1'b1)
    begin
    
    	region_active_d0 <= region_active;
    	region_active_d1 <= region_active_d0;
    	region_active_d2 <= region_active_d1;
    
    end
    else begin
       region_active_d0 <=1'b0; 
       region_active_d1 <=1'b0; 
       region_active_d2 <=1'b0; 
      end
      end
    
    always@(posedge pixelclk)
    begin
    	i_vsync_d0 <= i_vsync;
    	i_vsync_d1 <= i_vsync_d0;
    end
    
    //delay 2 clock
    //region_active_d0
    always@(posedge pixelclk)
    begin
    	if(region_active_d0 == 1'b1)
    		osd_x1 <= osd_x1 + 12'd1;
    	else
    		osd_x1 <= 12'd0;
    end
    
    
    always@(posedge pixelclk)
     begin
    	if(i_vsync_d1 == 1'b1 && i_vsync_d0 == 1'b0)
    		osd_ram_addr1 <= 16'd0;
    	else if(region_active == 1'b1)
    		osd_ram_addr1 <= osd_ram_addr1 + 16'd1;
     end

endmodule 