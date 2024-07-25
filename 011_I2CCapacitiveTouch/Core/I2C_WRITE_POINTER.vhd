library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity I2C_WRITE_POINTER is
port(
	RESET_N		   	: in std_logic;
	PT_CK	   	    : in std_logic;
	GO	   	        : in std_logic;
	POINTER	        : in std_logic_vector(7 downto 0); 
	SLAVE_ADDRESS   : in std_logic_vector(7 downto 0); 
	SDAI   	        : in std_logic;

	SDAO	        : out std_logic register;
	SCLO	        : out std_logic register;
	END_OK	        : out std_logic register;

    --for test
	ST	            : inout std_logic_vector(7 downto 0) register;
	ACK_OK	        : out std_logic register;
	CNT	            : inout std_logic_vector(7 downto 0) register;
	BYTE	        : inout std_logic_vector(7 downto 0) register
);
end;

architecture rtl of I2C_WRITE_POINTER is

-- 50MHZ CLOCK1 TEST
	signal 	DELY : std_logic_vector(7 downto 0) register;
	signal 	A    : std_logic_vector(8 downto 0) register;

begin
	process(PT_CK)
	begin
		if (rising_edge(PT_CK)) then --falling_edge(RESET_N) or rising_edge(PT_CK)
            if (RESET_N = '0') then
                ST <= x"00";
            else
                case ST is 
                    when x"00" =>
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                        ACK_OK <= '0';
                        CNT    <= x"00";
                        END_OK <= '1';
                        BYTE   <= x"00";
                        if (GO = '1') then
                            ST <= x"1E" ; --inital					
                        end if;
                    when x"01" => --start: 
                        ST     <= x"02"; 
                        SDAO   <= '0'; 
                        SCLO   <= '1';
                        A(8 downto 0) <= (SLAVE_ADDRESS(7 downto 0) & '1');--WRITE COMMAND
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
                            if (BYTE = x"01") then
                                ST <= x"06" ; 
                            else
                                CNT  <= x"00"; 
                                BYTE <= x"01"; 
                                A(8 downto 0) <= (POINTER(7 downto 0) & '1');  
                                ST <= x"02"; 
							end if;
                            if ( SDAI = '0') then
                                ACK_OK <= '1'; 
                            else 
                                ACK_OK <= '0'; 
                            end if;
                        else 
                            ST <= x"02";
                        end if;
                    when x"06" => --stop
                        ST <= x"07" ; 
                        SDAO   <= '0'; 
                        SCLO   <= '0';
                    when x"07" => --stop
                        ST <= x"08";  
                        SDAO   <= '0'; 
                        SCLO   <= '1';
                    when x"08" => --stop
                        ST <= x"09";  
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                    --stop
                    when x"09" =>
                        ST     <= x"1E"; 
                        SDAO   <= '1'; 
                        SCLO   <= '1';
                        ACK_OK <= '0';
                        CNT    <= x"00";
                        END_OK <= '1';
                        BYTE   <= x"00";					
                    -- END 
                    when x"1E" =>
                        if (GO = '0') then
                            ST <= x"1F";
                        end if;
                    --SLEEP UP
                    when x"1F" =>
                        END_OK <= '0';
                        CNT    <= x"00";
                        ST     <= x"20";	
                        SDAO   <= '0'; 
                        SCLO   <= '1';
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
                                ST <= x"05";
                                SCLO <= '0';
                            end if; 
                        end if;
                    when others => --'U', 'X', '-', etc.
                        ST <=  x"00";
                end case; --I2C START--
            end if;
        end if;
    end process;
end rtl;