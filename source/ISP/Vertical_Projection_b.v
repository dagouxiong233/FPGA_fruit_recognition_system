
module Vertical_Projection_r#(
       parameter IMG_WIDTH_LINE = 1024
      
	   )(
       input                          pixelclk,
	   input                          reset_n , 
      input                           en  ,   
	   input                          i_binary,
	   input                          i_hs    ,
	   input                          i_vs    ,
	   input                          i_de    ,       

	   input [11:0]                   i_hcount,
	   input [11:0]                   i_vcount,

       output                         O_binary,	   
	   output            [11:0]       hcount_l,
       output            [11:0]       hcount_r,
       output            [11:0]       vcount_l,
       output            [11:0]       vcount_r

		 );


 
parameter IDLE =   5'b00001;
parameter FRAME1 = 5'b00010;
parameter FRAME2 = 5'b00100;
parameter FRAME3 = 5'b01000;
parameter FRAME4 = 5'b10000;

wire                 TFT_VS_fall;
wire                 th_flag;
wire [11:0]          hcount;
wire [11:0]          vcount;
reg  [2:0]          frame_cnt;




reg          hs_r;
reg          vs_r;
reg          de_r;


assign    O_binary=i_binary;

assign o_hs = hs_r;
assign o_vs = vs_r;
assign o_de = de_r;

assign TFT_VS_fall = (!i_vs & (vs_r))?1'b1:1'b0;

assign th_flag = (i_binary )?1'b0:1'b1;

assign hcount = i_hcount;
assign vcount = i_vcount;

reg [4:0] c_state;
reg [4:0] n_state;

//reg [1:0] frame_cnt;
reg [11:0] i;

reg  [11:0] hcount_l1_r;
reg  [11:0] hcount_r1_r;
reg  [11:0] vcount_l1_r;
reg  [11:0] vcount_r1_r;
  
reg h_we;
reg [11:0] h_waddr;
reg [11:0] h_raddr ;
reg  h_di;
wire h_dout;
reg  h_dout_r;
reg  v_we;
reg [11:0] v_waddr;
reg [11:0] v_raddr;
reg  v_di;
wire v_dout;
reg  v_dout_r;
 
wire h_pedge = (h_dout & (!h_dout_r));
wire h_nedge = ((!h_dout) & h_dout_r);
wire v_pedge = (v_dout & (!v_dout_r));
wire v_nedge = ((!v_dout) & v_dout_r);
reg h_pedge_r;
reg h_nedge_r;
reg v_pedge_r;
reg v_nedge_r;

reg h_pedge_r0;
reg h_nedge_r0;
reg v_pedge_r0;
reg v_nedge_r0;


reg  [3:0] h_pedge_cnt;
reg  [3:0] h_nedge_cnt;
reg  [3:0] v_pedge_cnt;
reg  [3:0] v_nedge_cnt;

assign       hcount_l  = hcount_l1_r;
assign       hcount_r  = hcount_r1_r;
assign       vcount_l  = vcount_l1_r;
assign       vcount_r  = vcount_r1_r;

always @(posedge pixelclk )
    if(en) begin
  hs_r    <= i_hs;
  vs_r    <= i_vs;
  de_r    <= i_de;
  
  h_dout_r <= h_dout;
  v_dout_r <= v_dout;
  
  h_pedge_r <= h_pedge;
  h_nedge_r <= h_nedge;
  v_pedge_r <= v_pedge;
  v_nedge_r <= v_nedge;
  
  h_pedge_r0 <= h_pedge_r;
  h_nedge_r0 <= h_nedge_r;
  v_pedge_r0 <= v_pedge_r;
  v_nedge_r0 <= v_nedge_r;
end

//-------------------------------------------------------------
//frame counter 0 1 2 3 4   0 1 2 3 4 ...
//-------------------------------------------------------------
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    frame_cnt <=3'd0;
  else if(en) begin
    if(frame_cnt == 3'd4)
    frame_cnt <=3'd0;
  else if(TFT_VS_fall== 1'b1) //falling edge
    frame_cnt <= frame_cnt + 3'd1;
  else
    frame_cnt <= frame_cnt; 
    end  
end 


//FSM1
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
    c_state <= IDLE;
  else if(en)
    c_state <= n_state;
    else
    c_state <= IDLE;
end


//FSM2
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) 
     n_state <= IDLE;
  else case(c_state)
    IDLE:begin
	   if(i > (IMG_WIDTH_LINE-1))      // initial ram
		  n_state <= FRAME1;
		else 
		  n_state <= IDLE;
	 end
	 FRAME1:begin
	   if(frame_cnt == 3'd1)
		  n_state <= FRAME2;
		else
		  n_state <= FRAME1;
	 end
	 FRAME2:begin
	   if(frame_cnt == 3'd2)
		  n_state <= FRAME3;
		else
		  n_state <= FRAME2;
	 end
	 FRAME3:begin
	   if(frame_cnt == 3'd3)
		  n_state <= FRAME4;
		else
		  n_state <= FRAME3;
	 end
	 FRAME4:begin
	   if(frame_cnt == 3'd0)
		  n_state <= FRAME1;
		else
		  n_state <= FRAME4;
	 end
  endcase      
end

//FMS3
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n) begin 
     h_we <= 1'b0;
	 h_waddr <= 12'b0;
	 h_raddr <= 12'b0;
	 h_di <= 0;
	 v_we <= 1'b0;
	 v_waddr <= 12'b0;
	 v_raddr <= 12'b0;
	 v_di <= 0;
	 i <= 12'd0;

    hcount_l1_r<= 12'b0;
    hcount_r1_r<= 12'b0;
    vcount_l1_r<= 12'b0;

     vcount_r1_r<= 12'b0;

     h_pedge_cnt<=4'b0;
     h_nedge_cnt<=4'b0;
     v_pedge_cnt<=4'b0;
     v_nedge_cnt<=4'b0;
  end	 
  else case(c_state)
    IDLE: begin
	   if(i > (IMG_WIDTH_LINE-1)) begin
		  i<=i;
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;
		end  
		else begin

		  i <= i +1;
		  h_we <= 1;
		  h_waddr <= h_waddr +1;
		  h_di <= 0;
		  v_we <= 1;
		  v_waddr <= v_waddr +1;
		  v_di <= 0;
		end
	 end
    FRAME1:begin
	   if((hcount > 3)&& (vcount > 3)&& (!th_flag)) begin
		  h_we <= 1;
		  h_waddr <= hcount;
		  h_di <= 1;
		  v_we <= 1;
		  v_waddr <= vcount;
		  v_di <= 1;

		end
		else begin
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;


		end
	 end
	 FRAME2:begin
	  if(h_raddr < (IMG_WIDTH_LINE-1)) begin 
	     i <= 0;

	     h_raddr <= h_raddr + 1;
		 v_raddr <= v_raddr + 1;
         		  
		 if(h_pedge) h_pedge_cnt <= h_pedge_cnt +1;
	    if(h_pedge_r0 && h_pedge_cnt == 1) hcount_l1_r <= (h_raddr);
	  
	    if(h_nedge) h_nedge_cnt <= h_nedge_cnt +1;
	    if(h_nedge_r0 && h_nedge_cnt == 1) hcount_r1_r <= (h_raddr);
		 
		if(v_pedge) v_pedge_cnt <= v_pedge_cnt +1;
	    if(v_pedge_r0 && v_pedge_cnt == 1) vcount_l1_r <= (v_raddr );
	  
	    if(v_nedge) v_nedge_cnt <= v_nedge_cnt +1;
	    if(v_nedge_r0 && v_nedge_cnt == 1) vcount_r1_r <= (v_raddr);
	  end
		 

	  else begin
	     h_pedge_cnt <= h_pedge_cnt;
		 h_nedge_cnt <= h_nedge_cnt;
		  
		 v_pedge_cnt <= v_pedge_cnt;
		 v_nedge_cnt <= v_nedge_cnt;
		  
		 h_raddr <= h_raddr;
	     v_raddr <= v_raddr;
	    if(i < (IMG_WIDTH_LINE-1)) begin
		  i <= i + 1;
		  h_we <= 1;
		  h_waddr <= h_waddr +1;
		  h_di <= 0;
		  v_we <= 1;
		  v_waddr <= v_waddr +1;
		  v_di <= 0;
		 end	
		 else begin
		  i<=i;
		  h_we <= 0;
		  h_waddr <= 0;
		  h_di <= 0;
		  v_we <= 0;
		  v_waddr <= 0;
		  v_di <= 0;
		 end
	  end
	 end
	 FRAME3:begin
	    h_raddr <= 0;
	    v_raddr <= 0;
		h_pedge_cnt <= 4'b0;
		h_nedge_cnt <= 4'b0;
		v_pedge_cnt <= 4'b0;
		v_nedge_cnt <= 4'b0;
	 end
  endcase
end

		 
ram #(
       .IMG_WIDTH_LINE(IMG_WIDTH_LINE)
      )h_ram_inst(
	 .clk(pixelclk),
	 .rst_n(reset_n),
	
	 .we(h_we),
     .waddr(h_waddr),
     .raddr(h_raddr),
     .di   (h_di),
     .dout(h_dout)
	);
	
ram #(
      .IMG_WIDTH_LINE(IMG_WIDTH_LINE)
      )v_ram_inst(
	 .clk(pixelclk),
	 .rst_n(reset_n),
	
	 .we(v_we),
     .waddr(v_waddr),
     .raddr(v_raddr),
     .di   (v_di),
     .dout(v_dout)
	); 


endmodule