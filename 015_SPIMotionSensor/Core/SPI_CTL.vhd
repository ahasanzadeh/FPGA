
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SPI_CTL is
    --FSM--
    --WRITE SETTING
    generic(
        --WRITE SETTING --   
        constant CTRL_REG6      :integer := 9535; --x"253F"
        constant CTRL_REG1      :integer := 8343; --x"2097"
        constant INT1_CFG       :integer := 12543; --x"30ff"
        constant INT2_CFG       :integer := 13567; --x"34ff"
        constant INT1_SRC       :integer := 12799; --x"31ff"
        constant INT2_SRC       :integer := 13823; --x"35ff"
        constant CTRL_REG3      :integer := 8896; --x"22c0"
        constant CTRL_REG2      :integer := 8640; --x"21c0"
       
       
        --READ POINTER --   
        constant R_WHO_AM_I     :integer := 3840; --x"0F00" 
        constant R_OUT_X_L      :integer := 10240; --x"2800" 
        constant R_OUT_X_H      :integer := 10496; --x"2900"
        constant R_OUT_Y_L      :integer := 10752; --x"2A00" 
        constant R_OUT_Y_H      :integer := 11008; --x"2B00"
        constant R_OUT_Z_L      :integer := 11264; --x"2C00" 
        constant R_OUT_Z_H      :integer := 11520 --x"2D00"
    );

    port(
        RESET_N     :in std_logic; 
        CLK_50      :in std_logic; 
        OUT_X       :out std_logic_vector(15 downto 0) register; --two’s complement left-justified.\
        OUT_Y       :out std_logic_vector(15 downto 0) register; --two’s complement left-justified.\
        OUT_Z       :out std_logic_vector(15 downto 0) register; --two’s complement left-justified.\
        WHO_AM_I    :out std_logic_vector(7 downto 0) register;
        OUT_X_L     :inout std_logic_vector(7 downto 0) register;
        OUT_X_H     :inout std_logic_vector(7 downto 0) register;
        OUT_Y_L     :inout std_logic_vector(7 downto 0) register;
        OUT_Y_H     :inout std_logic_vector(7 downto 0) register;
        OUT_Z_L     :inout std_logic_vector(7 downto 0) register;
        OUT_Z_H     :inout std_logic_vector(7 downto 0) register;
        
        CS           :out std_logic register;
        SCLK         :out std_logic register;
        DIN          :inout std_logic register;
        DO           :in std_logic;
        DATA_RDY     :out std_logic register;
        
        --test
        SYS_CLK     :inout std_logic register;   
        ST          :inout std_logic_vector(7 downto 0) register;   
        BIT_CNT     :inout std_logic_vector(7 downto 0) register;   
        WORD_CNT    :inout std_logic_vector(7 downto 0) register;   
        RDATA       :inout std_logic_vector(15 downto 0) register;   
        CREG        :inout std_logic_vector(15 downto 0) register;   
        DIN_S       :out std_logic   
	);
end;

architecture rtl of SPI_CTL is
	-- Internal signal declaration goes HERE
	
	-- SIGNALs
    signal  CC    : std_logic_vector(7 downto 0) register;

begin
    --BYPASS
    DIN_S <= DIN; 
    
    --1MHZ  clock generator--
    process(CLK_50)
    begin
        if (rising_edge(CLK_50)) then 
            if (CC > x"19") then 
                SYS_CLK <= not SYS_CLK ;   
                CC <= (others => '0'); 
            else  
                CC <= CC + '1';
            end if;
        end if;
    end	process;

	process(SYS_CLK)
	begin
		if (rising_edge(SYS_CLK)) then --falling_edge(RESET_N) or rising_edge(PT_CK)
            if (RESET_N = '0') then
                ST          <= x"00";
                CS          <= '1'; 
                SCLK        <= '1';  
                DIN         <= '0';  	 
                BIT_CNT     <= x"00"; 
                DATA_RDY    <= '0'; 
                WORD_CNT    <= x"07"; 
            else
                case ST is 
                    -- WRITE
                    when x"00" =>
                        if  (WORD_CNT = x"00") then
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(CTRL_REG1, RDATA'length));
                        elsif (WORD_CNT = x"01") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(CTRL_REG6, RDATA'length)); 
                        elsif (WORD_CNT = x"02") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(INT1_CFG, RDATA'length)); 
                        elsif (WORD_CNT = x"03") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(INT2_CFG, RDATA'length)); 		
                        elsif (WORD_CNT = x"04") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(INT1_SRC, RDATA'length)); 		
                        elsif (WORD_CNT = x"05") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(INT2_SRC, RDATA'length)); 	
                        elsif (WORD_CNT = x"06") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(CTRL_REG3, RDATA'length)); 
                        elsif (WORD_CNT = x"07") then 
                            DIN                 <= '0'; 
                            RDATA(15 downto 0)  <= std_logic_vector(to_unsigned(CTRL_REG2, RDATA'length));
                        end if;                
                        BIT_CNT <= x"00"; 
                        ST      <= x"01";  			
                    when x"01" => 
                        DIN <= RDATA(15);
                        RDATA(15 downto 0)  <= (RDATA(14 downto 0) & '0');	  
                        CS  <= '0'; 
                        ST  <= x"02"; 
                    when x"02" => 
                        SCLK    <= '0';	  
                        BIT_CNT <= BIT_CNT + '1'; 
                        ST      <= x"03"; 
                    when x"03" => 
                        SCLK    <= '1';	  
                        if (BIT_CNT = x"10") then 
                            ST  <= x"04";  
                        else  
                            ST  <= x"01";
                        end if;  
                    when x"04" => 
                        ST  <= x"05";  	
                        CS  <= '1'; 
                        DIN <= '0';
                    when x"05" => --delay
                        if not (WORD_CNT = x"00") then  
                            WORD_CNT    <= WORD_CNT - 1; 
                            ST          <= x"00" ;
                        else 	  			
                            ST          <= x"0A"; 
                            WORD_CNT    <= x"00"; 
                        end if;
                    --Read 
                    when x"0A" =>
                        ST          <= x"0B";
                        CS          <= '1'; 
                        SCLK        <= '1';
                        BIT_CNT     <= x"10";  
                           if (WORD_CNT = x"00") then
                            CREG <= std_logic_vector(to_unsigned(R_WHO_AM_I, CREG'length)); 	 
                        elsif (WORD_CNT = x"01") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_X_L, CREG'length));  
                        elsif (WORD_CNT = x"02") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_X_H, CREG'length));    
                        elsif (WORD_CNT = x"03") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_Y_L, CREG'length));   
                        elsif (WORD_CNT = x"04") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_Y_H, CREG'length));   
                        elsif (WORD_CNT = x"05") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_Z_L, CREG'length));   
                        elsif (WORD_CNT = x"06") then
                            CREG <= std_logic_vector(to_unsigned(R_OUT_Z_H, CREG'length));   
                        end if;
                    when x"0B" =>
                        CREG    <= (x"8000" OR CREG);
                        CS      <= '0'; 
                        ST      <= x"0C";
                    when x"0C" =>
                        SCLK                <= '0';
                        DIN                 <= CREG(15);
                        CREG(15 downto 0)   <= (CREG(14 downto 0) & '0');
                        ST                  <= x"0D";
                    when x"0D" => 
                        SCLK    <= '1';
                        BIT_CNT <= BIT_CNT - 1;
                        ST      <= x"0E";
                    when x"0E" =>
                        RDATA(15 downto 0)  <= (RDATA(14 downto 0) & DO);       
                        if not ( BIT_CNT = x"00") then 
                            ST  <= x"0C"; 
                        else  
                            ST  <= x"0F"; 
                            CS  <= '1'; 
                        end	if;
                    when x"0F" =>
                        ST <= x"10"; 
                        if (WORD_CNT = x"07") then
                            WORD_CNT    <= x"00";
                        else  
                            WORD_CNT    <= WORD_CNT + 1;
                        end if;	
                           if (WORD_CNT = x"00") then 
                            WHO_AM_I <= RDATA(7 downto 0);       
                        elsif (WORD_CNT = x"01") then 
                            OUT_X_L  <= RDATA(7 downto 0);       
                        elsif (WORD_CNT = x"02") then 
                            OUT_X_H  <= RDATA(7 downto 0);       
                        elsif (WORD_CNT = x"03") then 
                            OUT_Y_L  <= RDATA(7 downto 0);       
                        elsif (WORD_CNT = x"04") then 
                            OUT_Y_H  <= RDATA(7 downto 0);    
                        elsif (WORD_CNT = x"05") then 
                            OUT_Z_L  <= RDATA(7 downto 0);       
                        elsif (WORD_CNT = x"06") then 
                            OUT_Z_H  <= RDATA(7 downto 0);  
                        end if;
                    when x"10" =>
                        ST  <= x"11"; 
                        if (WORD_CNT = x"00") then 
                            OUT_X <= (OUT_X_H & OUT_X_L);
                            OUT_Y <= (OUT_Y_H & OUT_Y_L);
                            OUT_Z <= (OUT_Z_H & OUT_Z_L);
                        end if; 
                    when x"11" =>
                        ST          <= x"12"; 
                        DATA_RDY    <= '1'; 
                    when x"12" =>
                        ST  <= x"13"; 
                    when x"13" =>
                        ST          <= x"0A"; 
                        DATA_RDY    <= '0'; 
                    when others => --'U', 'X', '-', etc.
                        ST <=  x"00";
                end case; --I2C START--
            end if;
        end if;
    end process;
end rtl;
