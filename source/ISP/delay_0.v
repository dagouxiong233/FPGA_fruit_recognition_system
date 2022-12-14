module delay_0(
input					pixelclk,
input                   rst_n,
//input                   en,
input       [23:0]      i_rgb_1,

output  reg [23:0]     o_rgb_0_r
   );
reg [23:0] o_rgb_1_0;
reg [23:0] o_rgb_1_1;
reg [23:0] o_rgb_1_2;
reg [23:0] o_rgb_1_3;
reg [23:0] o_rgb_1_4;
reg [23:0] o_rgb_1_5;
reg [23:0] o_rgb_1_6;
reg [23:0] o_rgb_1_7;
reg [23:0] o_rgb_1_8;
reg [23:0] o_rgb_1_9;
reg [23:0] o_rgb_1_10;
reg [23:0] o_rgb_1_11;
reg [23:0] o_rgb_1_12;
reg [23:0] o_rgb_1_13;
reg [23:0] o_rgb_1_14;
reg [23:0] o_rgb_1_15;
reg [23:0] o_rgb_1_16;
reg [23:0] o_rgb_1_17;
reg [23:0] o_rgb_1_18;
reg [23:0] o_rgb_1_19;
reg [23:0] o_rgb_1_20;
reg [23:0] o_rgb_1_21;
reg [23:0] o_rgb_1_22;
reg [23:0] o_rgb_1_23;
reg [23:0] o_rgb_1_24;
reg [23:0] o_rgb_1_25;
reg [23:0] o_rgb_1_26;
reg [23:0] o_rgb_1_27;
reg [23:0] o_rgb_1_28;
reg [23:0] o_rgb_1_29;
reg [23:0] o_rgb_1_30;
reg [23:0] o_rgb_1_31;
reg [23:0] o_rgb_1_32;
reg [23:0] o_rgb_1_33;
reg [23:0] o_rgb_1_34;
reg [23:0] o_rgb_1_35;
//reg [23:0] o_rgb_1_36;
//reg [23:0] o_rgb_1_37;
//reg [23:0] o_rgb_1_38;
//reg [23:0] o_rgb_1_39;
//reg [23:0] o_rgb_1_40;
//reg [23:0] o_rgb_1_41;
//reg [23:0] o_rgb_1_42;
//reg [23:0] o_rgb_1_43;
//reg [23:0] o_rgb_1_44;
//reg [23:0] o_rgb_1_45;
//reg [23:0] o_rgb_1_46;
//reg [23:0] o_rgb_1_47;
//reg [23:0] o_rgb_1_48;
//reg [23:0] o_rgb_1_49;
//reg [23:0] o_rgb_1_50;
//reg [23:0] o_rgb_1_51;
//reg [23:0] o_rgb_1_52;
//reg [23:0] o_rgb_1_53;
//reg [23:0] o_rgb_1_54;
//reg [23:0] o_rgb_1_55;
//reg [23:0] o_rgb_1_56;
//reg [23:0] o_rgb_1_57;
//reg [23:0] o_rgb_1_58;
//reg [23:0] o_rgb_1_59;
//reg [23:0] o_rgb_1_60;
//reg [23:0] o_rgb_1_61;
//reg [23:0] o_rgb_1_62;


always@(posedge pixelclk or negedge rst_n)
begin
   if(!rst_n) begin
     o_rgb_1_0<=0;
     o_rgb_1_1<=0;
     o_rgb_1_2<=0;
     o_rgb_1_3<=0; 
     o_rgb_1_4<=0;
     o_rgb_1_5<=0;
     o_rgb_1_6<=0;      
     o_rgb_1_7<=0;
     o_rgb_1_8<=0;
     o_rgb_1_9<=0; 
     o_rgb_1_10<=0;
     o_rgb_1_11<=0;
     o_rgb_1_12<=0;
     o_rgb_1_13<=0; 
     o_rgb_1_14<=0;
     o_rgb_1_15<=0;
     o_rgb_1_16<=0;
     o_rgb_1_17<=0;
     o_rgb_1_18<=0;
     o_rgb_1_19<=0;
     o_rgb_1_20<=0;
     o_rgb_1_21<=0;
     o_rgb_1_22<=0;
     o_rgb_1_23<=0;
     o_rgb_1_24<=0;
     o_rgb_1_25<=0;
     o_rgb_1_26<=0;
     o_rgb_1_27<=0;
     o_rgb_1_28<=0;
     o_rgb_1_29<=0;
     o_rgb_1_30<=0;
     o_rgb_1_31<=0;
     o_rgb_1_32<=0;
     o_rgb_1_33<=0;
     o_rgb_1_34<=0;
     o_rgb_1_35<=0;
//     o_rgb_1_36<=0;
//     o_rgb_1_37<=0;
//     o_rgb_1_38<=0;
//     o_rgb_1_39<=0; 
//     o_rgb_1_40<=0;
//     o_rgb_1_41<=0;
//     o_rgb_1_42<=0;
//     o_rgb_1_43<=0;
//     o_rgb_1_44<=0;
//     o_rgb_1_45<=0;
//     o_rgb_1_46<=0;
//     o_rgb_1_47<=0;
//     o_rgb_1_48<=0;
//     o_rgb_1_49<=0;
//     o_rgb_1_50<=0;
//     o_rgb_1_51<=0;
//     o_rgb_1_52<=0;
//     o_rgb_1_53<=0;
//     o_rgb_1_54<=0;
//     o_rgb_1_55<=0;
//     o_rgb_1_56<=0;
//     o_rgb_1_57<=0;
//     o_rgb_1_58<=0;
//     o_rgb_1_59<=0;
//     o_rgb_1_60<=0;
//     o_rgb_1_61<=0;
//     o_rgb_1_62<=0;
 
     o_rgb_0_r<=0;
 end
   else  begin
     o_rgb_0_r<=o_rgb_1_32;
//     o_rgb_1_62<=o_rgb_1_61;
//     o_rgb_1_61<=o_rgb_1_60;
//     o_rgb_1_60<=o_rgb_1_59;
//     o_rgb_1_59<=o_rgb_1_58;
//     o_rgb_1_58<=o_rgb_1_57;
//     o_rgb_1_57<=o_rgb_1_56;
//     o_rgb_1_56<=o_rgb_1_55;
//     o_rgb_1_55<=o_rgb_1_54;
//     o_rgb_1_54<=o_rgb_1_53;
//     o_rgb_1_53<=o_rgb_1_52;
//     o_rgb_1_52<=o_rgb_1_51;
//     o_rgb_1_51<=o_rgb_1_50;
//     o_rgb_1_50<=o_rgb_1_49;
//     o_rgb_1_49<=o_rgb_1_48;
//     o_rgb_1_48<=o_rgb_1_47;
//     o_rgb_1_47<=o_rgb_1_46;
//     o_rgb_1_46<=o_rgb_1_45;
//     o_rgb_1_45<=o_rgb_1_44;
//     o_rgb_1_44<=o_rgb_1_43;
//     o_rgb_1_43<=o_rgb_1_42;
//     o_rgb_1_42<=o_rgb_1_41;
//     o_rgb_1_41<=o_rgb_1_40;
//     o_rgb_1_40<=o_rgb_1_39;
//     o_rgb_1_39<=o_rgb_1_38;
//     o_rgb_1_38<=o_rgb_1_37;
//     o_rgb_1_37<=o_rgb_1_36;
//     o_rgb_1_36<=o_rgb_1_35;
     o_rgb_1_35<=o_rgb_1_34;
     o_rgb_1_34<=o_rgb_1_33;
     o_rgb_1_33<=o_rgb_1_32;
     o_rgb_1_32<=o_rgb_1_31;
     o_rgb_1_31<=o_rgb_1_30;
     o_rgb_1_30<=o_rgb_1_29;
     o_rgb_1_29<=o_rgb_1_28;
     o_rgb_1_28<=o_rgb_1_27;
     o_rgb_1_27<=o_rgb_1_26;
     o_rgb_1_26<=o_rgb_1_25;
     o_rgb_1_25<=o_rgb_1_24;
     o_rgb_1_24<=o_rgb_1_23;
     o_rgb_1_23<=o_rgb_1_22;
     o_rgb_1_22<=o_rgb_1_21;
     o_rgb_1_21<=o_rgb_1_20;
     o_rgb_1_20<=o_rgb_1_19;
     o_rgb_1_19<=o_rgb_1_18;
     o_rgb_1_18<=o_rgb_1_17;
     o_rgb_1_17<=o_rgb_1_16;
     o_rgb_1_16<=o_rgb_1_15;
     o_rgb_1_15<=o_rgb_1_14;
     o_rgb_1_14<=o_rgb_1_13;
     o_rgb_1_13<=o_rgb_1_12;
     o_rgb_1_12<=o_rgb_1_11;
     o_rgb_1_11<=o_rgb_1_10;
     o_rgb_1_10<=o_rgb_1_9;
     o_rgb_1_9<=o_rgb_1_8;
     o_rgb_1_8<=o_rgb_1_7;
     o_rgb_1_7<=o_rgb_1_6;
     o_rgb_1_6<=o_rgb_1_5;
     o_rgb_1_5<=o_rgb_1_4;
     o_rgb_1_4<=o_rgb_1_3;
     o_rgb_1_3<=o_rgb_1_2;
     o_rgb_1_2<=o_rgb_1_1;
     o_rgb_1_1<=o_rgb_1_0;
     o_rgb_1_0<=i_rgb_1;
end
end

endmodule