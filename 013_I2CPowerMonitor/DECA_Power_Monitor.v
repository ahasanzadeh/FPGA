




module DECA_Power_Monitor(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [7:0]		LED,

	//////////// Power Monitor //////////
	input 		          		PMONITOR_ALERT,
	output		          		PMONITOR_I2C_SCL,
	inout 		          		PMONITOR_I2C_SDA,

	//////////// SW //////////
	input 		     [1:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
//-- Power Monitor set ----
wire [15:0] CONFIGURATION;
wire [15:0] CALIBRATION ;
wire [15:0] MASK_ENABLE;	
wire [15:0] ALERT_LIMIT;

//-- Power Monitor result ----
wire [15:0] CURRENT;      
wire [15:0] VOLTAGE_BUS;  
wire [15:0] VOLTAGE_SENSE;
wire [15:0] WATTE;        
wire [15:0] DIE_ID;       

//---FOR SYSTEM RESET --	
wire RESET_N ; 

//---I2C CLOCK --	
wire CLK_400K ;

//---FOR CLOCK TEST --	
wire CK50_1_1HZ ; 
wire CK50_2_1HZ ; 
wire AD_1HZ ; 
wire I2C_1HZ ; 

//--for SIGNALTAPE ----
wire [7:0] WORD_ST;
wire [7:0] WORD_CNT;
wire [7:0] WORD_BYTE;	
wire       W_WORD_END ; 
wire       W_WORD_GO ;
wire [7:0] ST ;
wire [7:0] CNT;
wire [15:0]R_DATA ;

//=======================================================
//  Structural coding
//=======================================================

//-- Power Monitor set ----
assign MASK_ENABLE   = 16'h0000;	 // Alert configuration and conversion ready 
assign ALERT_LIMIT   = 16'h0000;  // Contains the limit value to compare selected alert function.

//-- Power Monitor Configuration set ----
assign CONFIGURATION = 16'h4127;

//-- Power Monitor Calibration set ----
assign CALIBRATION   =  17066  ; //Current 1LSB=0.1mA



//--RESET
assign RESET_N =KEY[0];
	
//--Power Monitor Controller --
POWER_MONITOR rt1 ( 
   .RESET_N (RESET_N),
   .CLK_50  (MAX10_CLK1_50),	
	//---IC SIDE---
	.PMONITOR_ALERT  (PMONITOR_ALERT),  
	.PMONITOR_I2C_SCL(PMONITOR_I2C_SCL),
	.PMONITOR_I2C_SDA(PMONITOR_I2C_SDA),	
	//----SETTING INPUT --- 
	.Configuration(CONFIGURATION),	
	.Calibration  (CALIBRATION  ), 	
	.Mask_Enable  (MASK_ENABLE  ), 	
	.Alert_Limit  (ALERT_LIMIT  ), 	
	//----OUTPUT --- 
	.Current       (CURRENT        ),
	.Bus_Voltage   (VOLTAGE_BUS    ),
	.Shunt_Voltage (VOLTAGE_SENSE  ),
	.Power         (WATTE          ), 
	.Die_ID    	   (DIE_ID         ),

	//-----for TEST----
	.CLK_400K   (CLK_400K),
	.I2C_LO0P   (I2C_LO0P ),	
	.ST   		(ST),
   .CNT  		(CNT) ,
	.W_WORD_END	(W_WORD_END)  ,
   .W_WORD_GO 	(W_WORD_GO ) ,
   .WORD_ST  	(WORD_ST  ),
   .WORD_CNT  	(WORD_CNT ),
   .WORD_BYTE	(WORD_BYTE),
   .R_DATA		(R_DATA)	
	);
	
	
//--for SingaltapeII Module--- 
TP	 t (
   .R_DATA    (R_DATA),
   .WORD_ST   (WORD_ST  ),
   .WORD_CNT  (WORD_CNT  ),
   .WORD_BYTE (WORD_BYTE),
   .W_WORD_END(W_WORD_END ) ,
   .W_WORD_GO (W_WORD_GO ),
   .RESET_N   (RESET_N) ,
   .SYS_CLK   (CLK_400K) ,
   .ST   	  (ST ),
   .CNT       (CNT),	
	.Configuration (CONFIGURATION),
	.Calibration   (CALIBRATION  ),
	.Mask_Enable   (MASK_ENABLE  ),
	.Alert_Limit   (ALERT_LIMIT  ),	
	.Current       (CURRENT          ),
	.Bus_Voltage   (VOLTAGE_BUS      ),
	.Shunt_Voltage (VOLTAGE_SENSE    ),
	.Power         (WATTE            ), 
	.Die_ID    	   (DIE_ID           ),
   .PMONITOR_I2C_SCL(PMONITOR_I2C_SCL), 
   .PMONITOR_I2C_SDA(PMONITOR_I2C_SDA)

);

//==============LED TEST=============
//---CLOCK TEST--
//CLOCKMEM C2  (  .CLK  (MAX10_CLK1_50) , .CLK_FREQ (50000000), . CK_1HZ (CK50_1_1HZ )  ) ; //50MHZ
//CLOCKMEM C3  (  .CLK  (MAX10_CLK2_50) , .CLK_FREQ (50000000), . CK_1HZ (CK50_2_1HZ )  ) ; //50MHZ
//CLOCKMEM C4  (  .CLK  (ADC_CLK_10)    , .CLK_FREQ (10000000), . CK_1HZ (AD_1HZ)  ) ;      //10MHZ
//CLOCKMEM C5  (  .CLK  (CLK_400K)      , .CLK_FREQ (400000)  , . CK_1HZ (I2C_1HZ )  ) ;    //400KHZ

//-- OUTPUT LED --
//assign LED [7:0]  = 8'hff ^ {  I2C_1HZ, AD_1HZ,  CK50_2_1HZ , CK50_1_1HZ   } ;

endmodule
