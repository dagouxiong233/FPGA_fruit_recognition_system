module line_shift(
    input clk,
    
    input          ycbcr_de,
    input          ycbcr_hs,
    
    input          shiftin,  
    output         taps0x,   
    output         taps1x    
);

reg  [2:0]  clken_dly;
reg  [9:0]  ram_rd_addr;
reg  [9:0]  ram_rd_addr_d0;
reg  [9:0]  ram_rd_addr_d1;
reg  [9:0]  ram_rd_addr_d2;
reg  [9:0]  ram_rd_addr_d3;
reg         shiftin_d0;
reg         shiftin_d1;
reg         shiftin_d2;
reg         taps0x_d0;





always@(posedge clk)begin
    if(ycbcr_hs)
        if(ycbcr_de)
            ram_rd_addr <= ram_rd_addr + 1 ;
        else
            ram_rd_addr <= ram_rd_addr ;
    else
           ram_rd_addr <= 0 ;
end 


always@(posedge clk) begin
    clken_dly <= { clken_dly[1:0] , ycbcr_de };
end

always@(posedge clk ) begin
    ram_rd_addr_d0 <= ram_rd_addr;
    ram_rd_addr_d1 <= ram_rd_addr_d0;
end

always@(posedge clk)begin
    shiftin_d0 <= shiftin;
    shiftin_d1 <= shiftin_d0;
    shiftin_d2 <= shiftin_d1;
end


dpram1 ram_1024x1_m0 (
    .clock(clk),          // INPUT
    .wren(clken_dly[2]),            // INPUT
    .data(shiftin_d2),            // INPUT[7:0] 
    .wraddress(ram_rd_addr_d1),  // INPUT[9:0] 
    .rdaddress(ram_rd_addr),  // INPUT[9:0] 
    .q(taps0x)                  // OUTPUT[7:0]
);
//寄存一次前一行图像的数据
always@(posedge clk ) begin
    taps0x_d0 <= taps0x;
end



dpram1 ram_1024x1_m1 (
    .clock(clk),          // INPUT
    .wren(clken_dly[1]),            // INPUT
    .data(taps0x_d0),            // INPUT[7:0] 
    .wraddress(ram_rd_addr),  // INPUT[9:0] 
    .rdaddress(ram_rd_addr_d0),  // INPUT[9:0] 
    .q(taps1x)                  // OUTPUT[7:0]
);

endmodule 