

module DECA_Gesture_Light_Sensor(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [7:0]		LED,

	//////////// Light Sensor //////////
	output		          		LIGHT_I2C_SCL,
	inout 		          		LIGHT_I2C_SDA,
	inout 		          		LIGHT_INT,

	//////////// SW //////////
	input 		     [1:0]		SW
);


//=======================================================
//  REG/WIRE declarations
//======================================================
wire [7:0] LEDS ; 
wire [15:0]DAT ; 
wire [15:0]PS1_DATA;
wire [15:0]PS2_DATA;
wire [15:0]PS3_DATA;
wire [17:0]PS_DATA;
wire       RESET_N ; 

//=======================================================
//  Structural coding
//=======================================================

assign RESET_N = KEY[0] ;

//---Light_Sensor Controller--  
LSEN_CTRL  lsen( 
   .RESET_N      (RESET_N) , 
   .CLK_50       (MAX10_CLK1_50),
	.LIGHT_I2C_SCL(LIGHT_I2C_SCL),
	.LIGHT_I2C_SDA(LIGHT_I2C_SDA),
	.LIGHT_INT    (LIGHT_INT),	
	.PS1_DATA     (PS1_DATA),		
	.PS2_DATA     (PS2_DATA),		
	.PS3_DATA     (PS3_DATA)	
	);

assign PS_DATA	= (PS1_DATA+PS2_DATA+PS3_DATA)/3  ; 

//--LEVEL Processor---
LEVEL_CAMP  cmp(
 .PS_DATA (PS_DATA) ,
 .LEVEL   (LEDS)
);
 

//LED DISPALY 
assign LED [7:0]  = 8'hff ^  LEDS ; 
 
endmodule
