-- ============================================================================
--	Developer: A.H.
--  State Machine for a trafic light with procedure
--  This is a design to be simulated by ModelSim, and implemented on MAX10 FPGA
-- ============================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
  
entity P010_StateMachineProcedure is
    generic(ci_ClockFrequencyHz : integer := 10000000); -- 10MHz

    port( 
		  -- INPUTs
        in_CLK1_50      : in std_logic; 
        in_Switch1      : in std_logic; -- Avtive low reset 

        -- OUTPUTs
        out_LED         : out std_logic_vector(7 downto 0) := (others => '1')
        ); 
end entity; 
    
architecture rtl of P010_StateMachineProcedure is 
    -- Enumerated type declaration and state signal declaration goes here
    type t_State is (t_NorthNext, t_StartNorth, t_North, t_StopNorth, 
                     t_WestNext,  t_StartWest,  t_West,  t_StopWest); 

	-- Internal signal declaration goes HERE 
    signal st_State : t_State; 

    -- Counter for counting clock periods, 1 minute max 
    signal si_Counter : integer range 0 to ci_ClockFrequencyHz * 60; 

    signal s_NorthRed    : std_logic; 
    signal s_NorthYellow : std_logic; 
    signal s_NorthGreen  : std_logic; 
    signal s_WestRed     : std_logic; 
    signal s_WestYellow  : std_logic; 
    signal s_WestGreen   : std_logic; 

    -- Architecture begins here
begin 
	-- Process 
    -- Timer: Counts seconds, minutes, and hours 
    process(in_CLK1_50) is 
		-- Internal variables declaration goes HERE

        -- Procedure for changing state after a given time 
        procedure p_ChangeState(st_ToState : t_State; 
                                 i_Minutes : integer := 0; 
                                 i_Seconds : integer := 0) is 
            variable vi_TotalSeconds : integer; 
            variable vi_ClockCycles  : integer; 
        begin 
            vi_TotalSeconds := i_Seconds + i_Minutes * 60; 
            vi_ClockCycles  := vi_TotalSeconds * ci_ClockFrequencyHz -1; 
            if si_Counter = vi_ClockCycles then 
                si_Counter <= 0; 
                st_State   <= st_ToState; 
            end if; 
        end procedure; 

    begin 
        if rising_edge(in_CLK1_50) then 
            -- Waiting for active low of reset signal
            if in_Switch1 = '0' then 
                st_State   <= t_NorthNext; 
                si_Counter <= 0; 
                
                s_NorthRed    <= '1'; 
                s_NorthYellow <= '0'; 
                s_NorthGreen  <= '0'; 
                s_WestRed     <= '1'; 
                s_WestYellow  <= '0'; 
                s_WestGreen   <= '0'; 
            else 
                -- Default values 
                s_NorthRed    <= '0'; 
                s_NorthYellow <= '0'; 
                s_NorthGreen  <= '0'; 
                s_WestRed     <= '0'; 
                s_WestYellow  <= '0'; 
                s_WestGreen   <= '0'; 

                si_Counter    <= si_Counter + 1; 

                case st_State is 
                    -- Red in all directions 
                    when t_NorthNext => 
                        s_NorthRed <= '1'; 
                        s_WestRed  <= '1'; 
                        -- If 5 seconds have passed 

                        p_ChangeState(t_StartNorth, i_Seconds => 5);

                    -- Red and yellow in north/south direction 
                    when t_StartNorth => 
                        s_NorthRed    <= '1'; 
                        s_NorthYellow <= '1'; 
                        s_WestRed     <= '1'; 
                        -- If 5 seconds have passed 
                        p_ChangeState(t_North, i_Seconds => 5); 

                    -- Green in north/south direction 
                    when t_North => 
                        s_NorthGreen <= '1'; 
                        s_WestRed    <= '1'; 

                        -- If 1 minute has passed 
                        p_ChangeState(t_StopNorth, i_Minutes => 1);

                    -- Yellow in north/south direction 
                    when t_StopNorth => 
                        s_NorthYellow <= '1'; 
                        s_WestRed     <= '1'; 
                        -- If 5 seconds have passed 
                        p_ChangeState(t_WestNext, i_Seconds => 5);

                    -- Red in all directions 
                    when t_WestNext => 
                        s_NorthRed <= '1'; 
                        s_WestRed  <= '1'; 
                        -- If 5 seconds have passed 
                        p_ChangeState(t_StartWest, i_Seconds => 5);

                    -- Red and yellow in west/east direction 
                    when t_StartWest => 
                        s_NorthRed   <= '1'; 
                        s_WestRed    <= '1'; 
                        s_WestYellow <= '1'; 
                        -- si_If 5 seconds have passed 
                        p_ChangeState(t_West, i_Seconds => 5);

                    -- Green in west/east direction 
                    when t_West => 
                        s_NorthRed  <= '1'; 
                        s_WestGreen <= '1'; 
                        -- If 1 minute has passed 
                        p_ChangeState(t_StopWest, i_Minutes => 1); 

                    -- Yellow in west/east direction 
                    when t_StopWest => 
                        s_NorthRed   <= '1'; 
                        s_WestYellow <= '1'; 
                        -- If 5 seconds have passed 
                        p_ChangeState(t_NorthNext, i_Seconds => 5);

                end case; 
            end if; 
        end if; 
    end process; 

    -- Assigning to std_logic_vector
    out_LED(0) <= not s_NorthRed;
    out_LED(1) <= not s_WestGreen;
    out_LED(2) <= not s_WestYellow;
    out_LED(3) <= not s_WestYellow;	 
    out_LED(4) <= not s_WestRed;
    out_LED(5) <= not s_NorthGreen;
    out_LED(6) <= not s_NorthYellow;
    out_LED(7) <= not s_NorthYellow;

end architecture;