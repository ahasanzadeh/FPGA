library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity I2C_READ is
port(
	RESET_N		   	: in std_logic;
	PT_CK	   	    : in std_logic;
	SLAVE_ADDRESS   : in std_logic_vector(7 downto 0); --button_x is low-active?
	GO	   	        : in std_logic;
	SDAI	        : in std_logic;

	SDAO	        : out std_logic register;
	SCLO	        : out std_logic register;
	END_OK	        : out std_logic register;
	DATA16	        : inout std_logic_vector(15 downto 0) register;

    --for test
	ST	            : inout std_logic_vector(7 downto 0) register;
	ACK_OK	        : out std_logic register;
	CNT	            : inout std_logic_vector(7 downto 0) register;
	A	            : inout std_logic_vector(8 downto 0) register;
	BYTE	        : inout std_logic_vector(7 downto 0) register
);
end;

architecture rtl of I2C_READ is

-- 50MHZ CLOCK1 TEST
	signal 	DELY        : std_logic_vector(7 downto 0) register;
	signal 	END_BYTE    : std_logic_vector(7 downto 0) register;

begin
	process(PT_CK)
	begin
		if (rising_edge(PT_CK)) then --falling_edge(RESET_N) or rising_edge(PT_CK)
            if (RESET_N = '0') then
                ST <= x"00";
                END_BYTE <= x"01";
            else
                case ST is 
                    when x"00" =>
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                        ACK_OK <= '0';
                        CNT    <= x"00";
                        END_OK <= '1';
                        BYTE   <= x"00";
                        DATA16 <= x"0000";
                        if (GO = '1') then
                            ST <= x"1E" ;					
                        end if;
                    --I2C READ-COMMAND
                    when x"01" => --start: 
                        ST     <= x"02"; 
                        SDAO   <= '0'; 
                        SCLO   <= '1';
                        A(8 downto 0) <= ((SLAVE_ADDRESS(7 downto 0) or x"01") & '1');--READ COMMAND
                    when x"02" => --start:
                        ST     <= x"03"; 
                        SDAO   <= '0'; 
                        SCLO   <= '0';
                    when x"03" => --start:
                        ST <= x"04"; 
                        SDAO   <= A(8); 
                        A(8 downto 0) <= (A(7 downto 0) & '0');
                    when x"04" => 
                        ST <= x"05"; 
                        SCLO <= '1'; 
                        CNT   <= CNT + 1;
                    when x"05" =>
                        SCLO <= '0'; 
                        if (CNT = x"09") then
                            ST <= x"06" ; 
                            if ( SDAI = '0') then
                                ACK_OK <= '1'; 
                            else 
                                ACK_OK <= '0'; 
                            end if;
                        else 
                            ST <= x"02";
                        end if;
                    --DATA READ
                    when x"06" =>
                        ST <= x"07" ; 
                        SDAO   <= '1'; 
                        SCLO   <= '0';
                        CNT <= x"00";
                    when x"07" =>
                        ST <= x"08";  
                        DELY <= x"00";
                        SCLO <= '1'; 
                        if not (CNT = 8) then
                            DATA16(15 downto 0) <= (DATA16(14 downto 0) & SDAI);
                        end if;
                        CNT <= CNT + 1;
                    when x"08" =>
                        DELY <= DELY + 1;
                        SCLO <= '0'; 
                        if (DELY = 2) then 			    
                            if (CNT = x"08") then
                                ST <= x"07";
                                if (BYTE  = END_BYTE) then
                                    SDAO <= '1'; 
                                else  
                                    SDAO <= '0';
                                end if;
                            elsif (CNT = x"09") then 
                                BYTE <= BYTE + 1;   
                                ST <= x"09"; 
                            else 
                                ST <= x"07";
                            end if;
                        end	if;
                    when x"09" =>
                        if  ( BYTE > END_BYTE ) then
                            ST <= x"0A"; 
                        else 
                            ST <= x"06";
                        end if;
                    when x"0A" => --stop
                        ST <= x"0B"; 
                        SDAO   <= '0'; 
                        SCLO   <= '0';
                    when x"0B" => --stop
                        ST <= x"0C"; 
                        SDAO   <= '0'; 
                        SCLO   <= '1';
                    when x"0C" => --stop
                        ST <= x"0D"; 
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                    when x"0D" =>
                        ST     <= x"1E"; 
                        END_OK <= '1';
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                        ACK_OK <= '0';
                        CNT    <= x"00";
                        BYTE   <= x"00";	
                    -- END
                    when x"1E" =>
                        if (GO = '0') then
                            ST <= x"1F";
                        end if;
                    -- END
                    --when x"1E" =>
                        --if (GO = '0') then
                            --ST <= x"1F";
                        --end if;
                    when x"1F" =>
                        END_OK <= '0';
                        ST     <= x"01";	
                    --SLEEP UP
                    when x"28" =>
                        END_OK<= '0';
                        CNT  <= x"00"; 
                        ST   <= x"20"; 
                        SDAO <= '0';
                        SCLO <= '1'; 
                        A(8 downto 0) <= (SLAVE_ADDRESS(7 downto 0) & '1');--WRITE COMMAND
                    when x"20" => --start
                        ST   <= x"21"; 
                        SDAO <= '0';
                        SCLO <= '0'; 
                    when x"21" =>--start
                        ST <= x"22"; 
                        SDAO   <= A(8); 
                        A(8 downto 0) <= (A(7 downto 0) & '0');
                    when x"22" =>--start
                        ST <= x"23"; 
                        SCLO <= '1'; 
                        CNT <= CNT + 1; 
                    when x"23" =>
                        if (CNT= x"09") then
                            DELY <= x"00";
                            ST <= x"24"; 
                        else 
                            ST <= x"20";
                            SCLO <= '0';
                        end if; 
                    when x"24" =>
                        DELY <= DELY + 1;
                        if ( DELY > x"05" )  then 
                            if ( SDAI = '1' ) then 
                                ST <= x"1F"; 
                                SDAO <= '1';
                                SCLO <= '1';
                            else  
                                ST <= x"01";
                                SCLO <= '0';
                            end if; 
                        end if;
                    when others => --'U', 'X', '-', etc.
                        ST <=  x"00";
                        END_BYTE <= x"01";
                end case; --I2C START--
            end if;
        end if;
    end process;
end rtl;







