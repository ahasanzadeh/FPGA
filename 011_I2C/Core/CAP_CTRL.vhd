library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity CAP_CTRL is
-- Main-ST 
--Pointer NUM
generic(
    constant SLAVE_ADDR             : integer := 110;--x"6E";
--WRITE
    constant P_LATCHED_BUTTON_STAT  : integer := 172;--x"AC";  
    constant P_PROX_EN              : integer := 38;--x"26";
    constant P_PROX_TOUCH_TH0       : integer := 42;--x"2A";
    constant P_PROX_TOUCH_TH1       : integer := 44;--x"2C";
    constant P_LATCHED_PROX_STAT    : integer := 175;--x"AF";
    constant P_PROX_CFG             : integer := 39;--x"27";
    constant P_BASE_THRESHOLD0      : integer := 12;--x"0C";
    constant P_BASE_THRESHOLD1      : integer := 13;--x"0D";
    constant P_PROX_POSITIVE_TH0    : integer := 53;--x"35";
--READ
    constant P_DEVICE_ID            : integer := 144;--x"90";
    constant P_FAMILY_ID            : integer := 143;--x"8F";
    constant P_DEVICE_REV           : integer := 146;--x"92";
    constant P_BUTTON_STAT          : integer := 170;--x"AA"; 
    constant P_PROX_STAT            : integer := 174--x"AE"
    );

port(
	RESET_N		   	    : in std_logic;
	CLK_50	   	        : in std_logic;
    CAP_SENSE_I2C_SCL	: out std_logic;
	CAP_SENSE_I2C_SDA	: inout std_logic;

    --SET IN
    SW_ACTIVE_POLARITY  : in std_logic;
	SW_PROX_EN          : in std_logic_vector(15 downto 0); 
	SW_PROX_TOUCH_TH0   : in std_logic_vector(15 downto 0); 
	SW_PROX_TOUCH_TH1   : in std_logic_vector(15 downto 0); 

    --Test or ST-BUS 
    Device_ID           : out std_logic_vector(15 downto 0) register;
    Family_ID           : out std_logic_vector(15 downto 0) register;
    Device_REV          : out std_logic_vector(15 downto 0) register;
    Button_STAT         : inout std_logic_vector(15 downto 0) register;
    Prox_STAT           : out std_logic_vector(15 downto 0) register;
    Prox_EN             : out std_logic_vector(15 downto 0) register;
    PROX_TOUCH_TH0      : out std_logic_vector(15 downto 0) register;
    PROX_TOUCH_TH1      : out std_logic_vector(15 downto 0) register;
    BASE_THRESHOLD0	    : out std_logic_vector(15 downto 0) register;
    BASE_THRESHOLD1     : out std_logic_vector(15 downto 0) register;
    F_STAT              : out std_logic_vector(15 downto 0);
    PROX_POSITIVE_TH0   : out std_logic_vector(15 downto 0) register;

    --test
    CLK_400K            : inout std_logic register;
    I2C_LO0P            : inout std_logic register;
    ST                  : inout std_logic_vector(7 downto 0) register;
    CNT                 : inout std_logic_vector(7 downto 0) register;
    W_WORD_END          : inout std_logic;
    W_WORD_GO           : inout std_logic register;

    WORD_ST             : inout std_logic_vector(7 downto 0);
    WORD_CNT            : inout std_logic_vector(7 downto 0);
    WORD_BYTE           : inout std_logic_vector(7 downto 0);
    R_DATA              : inout std_logic_vector(15 downto 0);
    SDAI_W              : inout std_logic
);
end;

architecture rtl of CAP_CTRL is

    signal 	DELY 					: std_logic_vector(7 downto 0) register;
	signal 	SLAVE_ADDRESS_S 	    : std_logic_vector(7 downto 0) register;

    -- I2C clock 400k generater 
    signal C_DELAY                  : std_logic_vector(31 downto 0) register;

    --MAIN-ST END 
    --I2C-BUS
    signal SDAO            : std_logic; 

    -- I2C WRITE WORD 
    signal W_WORD_SCL      : std_logic; 
    signal W_WORD_REG      : std_logic_vector(7 downto 0) register;
    signal W_WORD_DATA     : std_logic_vector(15 downto 0) register;
    signal W_WORD_SDAO     : std_logic; 

    component I2C_WRITE_WORD is 
		port(
            RESET_N		   	: in std_logic;
            PT_CK	   	    : in std_logic;
            GO	   	        : in std_logic;
            POINTER	        : in std_logic_vector(7 downto 0); 
            SLAVE_ADDRESS   : in std_logic_vector(7 downto 0); 
            WDATA16         : in std_logic_vector(15 downto 0); 
            SDAI   	        : in std_logic;
        
            SDAO	        : out std_logic register;
            SCLO	        : out std_logic register;
            END_OK	        : out std_logic register;
        
            --for test
            SDAI_W	        : inout std_logic;
            ST	            : inout std_logic_vector(7 downto 0) register;
            --ACK_OK	        : out std_logic register;
            CNT	            : inout std_logic_vector(7 downto 0) register;
            BYTE	        : inout std_logic_vector(7 downto 0) register
        );
	end component;

    -- I2C WRITE POINTER 
    signal W_POINTER_SCL    : std_logic; 
    signal W_POINTER_END    : std_logic;
    signal W_POINTER_GO     : std_logic register;
    signal W_POINTER_REG    : std_logic_vector(7 downto 0) register; 
    signal W_POINTER_SDAO   : std_logic;

    component I2C_WRITE_POINTER is 
		port(
            RESET_N		   	: in std_logic;
            PT_CK	   	    : in std_logic;
            GO	   	        : in std_logic;
            POINTER	        : in std_logic_vector(7 downto 0); 
            SLAVE_ADDRESS   : in std_logic_vector(7 downto 0); 
            SDAI   	        : in std_logic;
        
            SDAO	        : out std_logic register;
            SCLO	        : out std_logic register;
            END_OK	        : out std_logic register
        
            --for test
            --ST	            : inout std_logic_vector(7 downto 0) register;
            --ACK_OK	        : out std_logic register;
            --CNT	            : inout std_logic_vector(7 downto 0) register;
            --BYTE	        : inout std_logic_vector(7 downto 0) register
            );
	end component;

    -- I2C READ 
    signal R_SCL            : std_logic;                      
    signal R_END            : std_logic;  
    signal R_GO             : std_logic register; 
    signal R_SDAO           : std_logic;  
    signal R_DATA_S          : std_logic_vector(15 downto 0);
    
    component I2C_READ is 
		port(
            RESET_N         : in std_logic;
            PT_CK           : in std_logic;
            GO              : in std_logic;
            SLAVE_ADDRESS   : in std_logic_vector(7 downto 0);
            SDAI            : in std_logic;

            SDAO            : out std_logic register;
            SCLO            : out std_logic register;
            END_OK          : out std_logic register;
            DATA16          : inout std_logic_vector(15 downto 0) register
            --for test        
            --ST              : inout std_logic_vector(7 downto 0) register;
            --ACK_OK          : out std_logic register;
            --CNT             : inout std_logic_vector(7 downto 0) register;
            --BYTE            : inout std_logic_vector(7 downto 0) register 
		);
	end component;

begin
    F_STAT(0) <= Button_STAT(0);
    F_STAT(1) <= Button_STAT(1);

    -- I2C clock 400k generater 
    process(CLK_50)
    begin
        if (rising_edge(CLK_50)) then 
            if ( C_DELAY > x"40" ) then --125/2 
                CLK_400K <= not CLK_400K; 
                C_DELAY  <= (others => '0'); 
            else 
                C_DELAY  <= C_DELAY + 1 ; 
            end if;
        end if;
    end process;


	process(CLK_400K)
	begin
		if (rising_edge(CLK_400K)) then --falling_edge(RESET_N) or rising_edge(PT_CK)
            if (RESET_N = '0') then
                ST <= x"00";
            else
                case ST is 
                    when x"00" =>
                        ST              <= x"1E"; --Config Reg
                        W_POINTER_GO    <= '1';
                        R_GO            <= '1';		 
                        W_WORD_GO       <= '1';		
                    --READ			
                    when x"01" => --delay 
                        ST     <= x"02"; 
                    when x"02" => 
                        if (CNT = x"05")  then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_DEVICE_ID, W_POINTER_REG'length));   
                        elsif (CNT = x"01") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_FAMILY_ID, W_POINTER_REG'length)); 
                        elsif (CNT = x"02") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_DEVICE_REV, W_POINTER_REG'length)); 
                        elsif (CNT = x"03") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_BUTTON_STAT, W_POINTER_REG'length)); 
                        elsif (CNT = x"04") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_PROX_STAT, W_POINTER_REG'length)); 
                        elsif (CNT = x"00") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_PROX_EN, W_POINTER_REG'length)); 
                        elsif (CNT = x"06") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_PROX_TOUCH_TH0, W_POINTER_REG'length)); 
                        elsif (CNT = x"07") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_PROX_TOUCH_TH1, W_POINTER_REG'length)); 
                        elsif (CNT = x"08") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_BASE_THRESHOLD0, W_POINTER_REG'length)); 
                        elsif (CNT = x"09") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_BASE_THRESHOLD1, W_POINTER_REG'length)); 
                        elsif (CNT = x"0A") then
                            W_POINTER_REG <= std_logic_vector(to_unsigned(P_PROX_POSITIVE_TH0, W_POINTER_REG'length)); 
                        end if;
                        if ( W_POINTER_END = '1') then
                            W_POINTER_GO    <= '0'; 
                            ST              <= x"03"; 
                            DELY            <= x"00";
                        end if;               -- Write ID pointer 
                    when x"03" => 
                        DELY <= DELY + 1;
                        if (DELY = x"02") then 
                            W_POINTER_GO  <= '1';
                            ST <= x"04"; 
                        end if;
                    when x"04" => 
                        if (W_POINTER_END = '1') then
                            ST <= x"05"; 
                        end if;
                    when x"05" => --delay
                        ST <= x"06" ; 
                    --Read DATA
                    when x"06" => --stop
                        if (R_END = '1') then
                            R_GO <= '0';
                            ST   <= x"07";
                            DELY <= x"00"; 
                        end if;
                    when x"07" => --stop
                        DELY <= DELY + 1;
                        if (DELY = x"02") then 	 
                            R_GO <= '1';
                            ST   <= x"08" ; 
                        end if;
                    when x"08" => --delay
                        ST <= x"09";  
                    when x"09" =>
                        if (R_END = '1') then 
                            if ( CNT = x"05") then
                                Device_ID <= R_DATA; 
                            elsif (CNT = x"01") then
                                Family_ID <= R_DATA; 
                            elsif (CNT = x"02") then
                                Device_REV <= R_DATA;   
                            elsif (CNT = x"03") then
                                if (SW_ACTIVE_POLARITY = '1') then
                                    Button_STAT <= R_DATA;
                                else
                                    Button_STAT <= (x"FFFF" XOR R_DATA); 
                                end if;  
                            elsif (CNT = x"04") then
                                if (SW_ACTIVE_POLARITY = '1') then
                                    Prox_STAT <= R_DATA;
                                else
                                    Prox_STAT <= (x"FFFF" XOR R_DATA); 
                                end if;      
                            elsif (CNT = x"00") then
                                Prox_EN <= R_DATA; 
                            elsif (CNT = x"06") then
                                PROX_TOUCH_TH0 <= R_DATA; 
                            elsif (CNT = x"07") then
                                PROX_TOUCH_TH1 <= R_DATA; 
                            elsif (CNT = x"08") then
                                BASE_THRESHOLD0 <= R_DATA; 
                            elsif (CNT = x"09") then
                                BASE_THRESHOLD1 <= R_DATA; 
                            elsif (CNT = x"0A") then
                                PROX_POSITIVE_TH0 <= R_DATA;	
                            end if;
                            ST  <= x"0A"; 	
                            CNT <= CNT + 1;
                        end if;   
                    when x"0A" =>
                        if (CNT = x"0B") then
                            CNT <= x"00";
                            ST  <= x"1E";
                        else
                            ST <=  x"01"; 
                        end if;
                        W_POINTER_GO <= '1';
                        R_GO         <= '1';		 
                        W_WORD_GO    <= '1'; 
                    --READ	 

                    --WRITE WORD
                    when x"1E" =>
                        CNT <= x"00";
                        ST <= x"1F";
                    when x"1F" =>
                        if (CNT = x"00") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_PROX_EN, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (SW_PROX_EN(7 downto 0) & SW_PROX_EN(7 downto 0));
                        elsif (CNT = x"01") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_LATCHED_BUTTON_STAT, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '0');
                        elsif (CNT = x"02") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_PROX_TOUCH_TH0, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= SW_PROX_TOUCH_TH0(15 downto 0);
                        elsif (CNT = x"03") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_PROX_TOUCH_TH1, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= SW_PROX_TOUCH_TH1(15 downto 0);
                        elsif (CNT = x"04") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_LATCHED_PROX_STAT, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '0');  
                        elsif (CNT = x"05") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_PROX_CFG, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '1');  
                        elsif (CNT = x"06") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_BASE_THRESHOLD0, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '0');  
                        elsif (CNT = x"07") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_BASE_THRESHOLD1, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '0');  
                        elsif (CNT = x"08") then
                            W_WORD_REG(7 downto 0) <= std_logic_vector(to_unsigned(P_PROX_POSITIVE_TH0, W_WORD_REG'length));
                            W_WORD_DATA(15 downto 0) <= (others => '0');  
                        end if;
                        if (W_WORD_END = '1') then  
                            W_WORD_GO   <= '0';
                            ST          <= x"20";
                            DELY        <= x"00";
                        end if;
                    -- Write ID pointer 
                    when x"20" => 
                        DELY <= DELY + 1;
                        if (DELY = x"02") then
                            W_WORD_GO   <= '1'; 
                            ST          <= x"21"; 
                        end if;
                    when x"21" =>--delay
                        ST <= x"22"; 
                    when x"22" =>
                        if (W_WORD_END = '1') then 
                            ST <= x"23"; 
                            CNT <= CNT + 1; 
                        end if;
                    when x"23" =>
                        if (CNT= x"09") then
                            ST  <= x"01";
                            CNT <= x"00"; 
                            I2C_LO0P <= not I2C_LO0P;
                        else 
                            ST <= x"1F";
                        end if; 
                    when others => --'U', 'X', '-', etc.
                        ST <=  x"00";
                end case; --I2C START--
            end if;
        end if;
    end process;




    --MAIN-ST END 
    --I2C-BUS

    CAP_SENSE_I2C_SCL <= (W_POINTER_SCL and R_SCL and W_WORD_SCL);
    SDAO              <= (W_POINTER_SDAO and R_SDAO and W_WORD_SDAO);
    process(SDAO)
    begin
        if (SDAO = '1') then 
            CAP_SENSE_I2C_SDA <= 'Z';
        else
            CAP_SENSE_I2C_SDA <= '0';
        end if;
    end process;

    
    wrd: I2C_WRITE_WORD  
    port map( 
        RESET_N        => RESET_N,
        PT_CK          => CLK_400K,
        GO             => W_WORD_GO,
        POINTER        => W_WORD_REG,
		  WDATA16	        => W_WORD_DATA,
        SLAVE_ADDRESS  => std_logic_vector(to_unsigned(SLAVE_ADDR, SLAVE_ADDRESS_S'length)),
        SDAI           => CAP_SENSE_I2C_SDA,
        SDAO           => W_WORD_SDAO,
        SCLO           => W_WORD_SCL ,
        END_OK         => W_WORD_END,
        --for test 
        ST             => WORD_ST ,
        CNT            => WORD_CNT,
        BYTE           => WORD_BYTE,
        SDAI_W         => SDAI_W
    );
   
    wpt: I2C_WRITE_POINTER  
    port map( 
        RESET_N         => RESET_N,
        PT_CK           => CLK_400K,
        GO              => W_POINTER_GO,
        POINTER         => W_POINTER_REG,
        SLAVE_ADDRESS   => std_logic_vector(to_unsigned(SLAVE_ADDR, SLAVE_ADDRESS_S'length)),
        SDAI            => CAP_SENSE_I2C_SDA,
        SDAO            => W_POINTER_SDAO,
        SCLO            => W_POINTER_SCL,
        END_OK          => W_POINTER_END	
    );

    --Swap Hi-8 and Low-8
    R_DATA <= (R_DATA_S(7 downto 0) & R_DATA_S(15 downto 8)) ; 

    rd: I2C_READ
    port map(  
        RESET_N         => RESET_N,
        PT_CK           => CLK_400K,
        GO              => R_GO,
        SLAVE_ADDRESS   => std_logic_vector(to_unsigned(SLAVE_ADDR, SLAVE_ADDRESS_S'length)),
        SDAI            => CAP_SENSE_I2C_SDA,
        SDAO            => R_SDAO,
        SCLO            => R_SCL,
        END_OK          => R_END,
        DATA16          => R_DATA_S
    );

end rtl;







