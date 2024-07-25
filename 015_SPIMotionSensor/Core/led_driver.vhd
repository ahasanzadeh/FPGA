library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity led_driver is
    port(
        iRSTN       :in std_logic;
        iCLK        :in std_logic;
        iDIG        :in std_logic_vector(9 downto 0);
        iG_INT2     :in std_logic;
        oLED        :inout std_logic_vector(7 downto 0) register;
        fine_tune   :in std_logic
	);
end;

architecture rtl of led_driver is
	-- Internal signal declaration goes HERE
	
	-- REG/WIRE declarations
    signal select_data      :std_logic_vector(4 downto 0) register;
    signal signed_bit       :std_logic;
    signal abs_select_high  :std_logic_vector(3 downto 0);
    signal ig_int2_dly      :std_logic register;
    signal dig_latch        :std_logic register;
    signal dig_acc_act      :std_logic register;
    signal dig_1            :std_logic_vector(9 downto 0) register;
    signal dig_2            :std_logic_vector(9 downto 0) register;
    signal dig_3            :std_logic_vector(9 downto 0) register;
    signal dig_4            :std_logic_vector(9 downto 0) register;
    signal dig_5            :std_logic_vector(9 downto 0) register;
    signal dig_6            :std_logic_vector(9 downto 0) register;
    signal dig_7            :std_logic_vector(9 downto 0) register;
    signal dig_8            :std_logic_vector(9 downto 0) register;
    signal dig_9            :std_logic_vector(9 downto 0) register;
    signal dig_10           :std_logic_vector(9 downto 0) register;
    signal dig_11           :std_logic_vector(9 downto 0) register;
    signal dig_12           :std_logic_vector(9 downto 0) register;
    signal dig_13           :std_logic_vector(9 downto 0) register;
    signal dig_14           :std_logic_vector(9 downto 0) register;
    signal dig_15           :std_logic_vector(9 downto 0) register;
    signal dig_16           :std_logic_vector(9 downto 0) register;
    signal dig_17           :std_logic_vector(9 downto 0) register;
    signal dig_acc          :std_logic_vector(13 downto 0) register;
    signal dig_new          :std_logic_vector(9 downto 0);
    signal select_data_upd  :std_logic register;
    signal led_upd          :std_logic register;
    signal dig_offset       :std_logic_vector(9 downto 0) register;
    signal dig_offset_upd   :std_logic register;
    signal dig_offset_acc   :std_logic_vector(13 downto 0) register;
    signal dig_off_acc_enb  :std_logic register;
    signal dig_offset_dcnt  :std_logic_vector(15 downto 0) register;
    signal pre_dig_offset   :std_logic_vector(9 downto 0);
    signal det_dig_offset   :std_logic register;
    signal oLED1            :std_logic_vector(7 downto 0) register;

	COMPONENT altdpram
		GENERIC
			( WIDTH          : NATURAL;
			  WIDTHAD        : NATURAL;
			  NUMWORDS       : NATURAL;
			  LPM_FILE       : STRING := "UNUSED";
			  LPM_HINT       : STRING := "USE_EAB=ON";
			  INDATA_REG     : STRING := "UNREGISTERED";
			  INDATA_ACLR    : STRING := "OFF";
			  WRADDRESS_REG  : STRING := "UNREGISTERED";
			  WRADDRESS_ACLR : STRING := "OFF";
			  WRCONTROL_REG  : STRING := "UNREGISTERED";
			  WRCONTROL_ACLR : STRING := "OFF";
			  RDADDRESS_REG  : STRING := "UNREGISTERED";
			  RDADDRESS_ACLR : STRING := "OFF";
			  RDCONTROL_REG  : STRING := "UNREGISTERED";
			  RDCONTROL_ACLR : STRING := "OFF";
			  OUTDATA_REG    : STRING := "UNREGISTERED";
			  OUTDATA_ACLR   : STRING := "OFF");

		 PORT (wren, inclock, outclock, aclr, outclocken: IN STD_LOGIC := '0';
			  data: IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
			  wraddress, rdaddress: IN STD_LOGIC_VECTOR(WIDTHAD-1 DOWNTO 0);
			  inclocken, rden: IN STD_LOGIC := '1';
			  q: OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0) );
	END COMPONENT;	 
	 
	COMPONENT lpm_counter
		GENERIC (LPM_WIDTH: POSITIVE;
			LPM_MODULUS: NATURAL := 0;
			LPM_DIRECTION: STRING := "UNUSED";
			LPM_AVALUE: STRING := "UNUSED";
			LPM_SVALUE: STRING := "UNUSED";
			LPM_PVALUE: STRING := "UNUSED";	  
			LPM_TYPE: STRING := "LPM_COUNTER";
			LPM_HINT : STRING := "UNUSED");
		PORT (data: IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
			clock: IN STD_LOGIC;
			clk_en, cnt_en, updown: IN STD_LOGIC := '1';
			sload, sset, sclr, aload, aset, aclr, cin: IN STD_LOGIC := '0';
			cout: OUT STD_LOGIC;
			--eq: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);	  
			q: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0));
	END COMPONENT;	 
	 
	COMPONENT lpm_compare
		GENERIC (LPM_WIDTH: POSITIVE;
			LPM_REPRESENTATION: STRING := "UNSIGNED";
			LPM_PIPELINE: INTEGER := 0;
			LPM_TYPE: STRING := "LPM_COMPARE";
			LPM_HINT: STRING := "UNUSED");
		PORT (dataa, datab: IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
			aclr, clock: IN STD_LOGIC := '0';
		  clken: IN STD_LOGIC := '1';
			agb, ageb, aeb, aneb, alb, aleb: OUT STD_LOGIC);
	END COMPONENT;	 
	 
	COMPONENT lpm_constant
   GENERIC (LPM_WIDTH: POSITIVE;
      LPM_CVALUE: NATURAL;
      LPM_STRENGTH: STRING := "UNUSED";
      LPM_TYPE: STRING := "LPM_CONSTANT";
      LPM_HINT: STRING := "UNUSED");
   PORT (result: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0));
	END COMPONENT;

begin 
    --dig_offset bus
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_offset <= "0000000000";
            else  
                if (dig_offset_upd = '1') then
                    dig_offset <= dig_offset_acc(13 downto 4);
                else
                    dig_offset <= dig_offset;
                end if;
            end if;
        end if;
    end	process;

    --dig_offset_upd signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_offset_upd <= '0';
            else  
                if ((dig_off_acc_enb = '1')  AND  (dig_acc_act = '1') AND  (dig_offset_dcnt = x"0000")) then
                    dig_offset_upd <= '1';
                else
                    dig_offset_upd <= '0';
                end if;
            end if;
        end if;
    end	process;

    --dig_offset_acc bus
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_offset_acc <= "00000000000000";
            else  
                if ((dig_off_acc_enb = '1') AND (dig_acc_act = '1')) then
                    dig_offset_acc <= dig_offset_acc + ("0000" & pre_dig_offset) ;
                else
                    dig_offset_acc <= dig_offset_acc ;
                end if;
            end if;
        end if;
    end	process;

    --dig_off_acc_enb signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_off_acc_enb <= '0';
            else  
                if ((dig_acc_act = '1') AND (dig_offset_dcnt = x"0010")) then
                    dig_off_acc_enb <= '1';
                else
                    if ((dig_acc_act = '1') AND (dig_offset_dcnt = x"0000")) then
                        dig_off_acc_enb <= '0';
                    else
                        dig_off_acc_enb <= dig_off_acc_enb;
                    end if;
                end if;
            end if;
        end if;
    end	process;

    --dig_offset_dcnt bus
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_offset_dcnt <= "0000010011100100";--x"1390" / 4  ;  -- 5sec * (1000ms/1ms)
            else  
                if (dig_acc_act = '1') then
                    if (dig_offset_dcnt = x"0000") then
                        dig_offset_dcnt <= x"0000";
                    else
                        dig_offset_dcnt <= dig_offset_dcnt - x"0001";
                    end if;
                else
                    dig_offset_dcnt <= dig_offset_dcnt;
                end if;
            end if;
        end if;
    end	process;

    --pre_dig_offset bus 
    pre_dig_offset <= "1000000000" - iDIG;

    --det_dig_offset signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                det_dig_offset <= '1';
            else  
                if (dig_offset_upd = '1') then
                    det_dig_offset <= '0';
                else
                    det_dig_offset <= det_dig_offset ;
                end if;
            end if;
        end if;
    end	process;

    --ig_int2_dly signal 
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                ig_int2_dly <= '0';
            else  
                ig_int2_dly <= iG_INT2;
            end if;
        end if;
    end	process;

    --dig_latch signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_latch <= '0';
            else  
                if ((iG_INT2 = '0') AND (ig_int2_dly = '1')) then
                    dig_latch <= '1';
                else
                    dig_latch <= '0';
                end if;
            end if;
        end if;
    end	process;

    --dig_latch signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_acc_act <= '0';
            else  
                dig_acc_act <= dig_latch;
            end if;
        end if;
    end	process;

    --iDIG to dig_17 shift 
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_1  <= "0000000000";
                dig_2  <= "0000000000";
                dig_3  <= "0000000000";
                dig_4  <= "0000000000";
                dig_5  <= "0000000000";
                dig_6  <= "0000000000";
                dig_7  <= "0000000000";
                dig_8  <= "0000000000";
                dig_9  <= "0000000000";
                dig_10 <= "0000000000";
                dig_11 <= "0000000000";
                dig_12 <= "0000000000";
                dig_13 <= "0000000000";
                dig_14 <= "0000000000";
                dig_15 <= "0000000000";
                dig_16 <= "0000000000";
                dig_17 <= "0000000000";
            else  
                if (dig_latch = '1') then 
                    dig_1  <= iDIG + dig_offset ;
                    dig_2  <= dig_1  ;
                    dig_3  <= dig_2  ;
                    dig_4  <= dig_3  ;
                    dig_5  <= dig_4  ;
                    dig_6  <= dig_5  ;
                    dig_7  <= dig_6  ;
                    dig_8  <= dig_7  ;
                    dig_9  <= dig_8  ;
                    dig_10 <= dig_9  ;
                    dig_11 <= dig_10 ;
                    dig_12 <= dig_11 ;
                    dig_13 <= dig_12 ;
                    dig_14 <= dig_13 ;
                    dig_15 <= dig_14 ;
                    dig_16 <= dig_15 ;
                    dig_17 <= dig_16 ;
                else
                    dig_1  <= dig_1  ;
                    dig_2  <= dig_2  ;
                    dig_3  <= dig_3  ;
                    dig_4  <= dig_4  ;
                    dig_5  <= dig_5  ;
                    dig_6  <= dig_6  ;
                    dig_7  <= dig_7  ;
                    dig_8  <= dig_8  ;
                    dig_9  <= dig_9  ;
                    dig_10 <= dig_10 ;
                    dig_11 <= dig_11 ;
                    dig_12 <= dig_12 ;
                    dig_13 <= dig_13 ;
                    dig_14 <= dig_14 ;
                    dig_15 <= dig_15 ;
                    dig_16 <= dig_16 ;
                    dig_17 <= dig_17 ;
                end if;
            end if;
        end if;
    end	process;

    --dig_acc bus
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                dig_acc <= "00000000000000";
            else  
                if (dig_acc_act = '1') then
                    dig_acc <= dig_acc + ("0000" & dig_1(9 downto 0)) - ("0000" & dig_17(9 downto 0));
                else
                    dig_acc <= dig_acc ;
                end if;
            end if;
        end if;
    end	process;

    --dig_new bus
    dig_new <= dig_acc(13 downto 4);

    --select_data_upd signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                select_data_upd <= '0';
            else  
                select_data_upd <= dig_acc_act ;
            end if;
        end if;
    end	process;

    --led_upd signal
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                led_upd <= '0';
            else  
                led_upd <= select_data_upd;
            end if;
        end if;
    end	process;

    --select_data bus
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                select_data <= "00000";
            else  
                if (select_data_upd = '1') then
                    if (fine_tune = '1') then
                        if (dig_new(9) = '1') then
                            if (dig_new(8 downto 5) = x"0") then
                                select_data <= (dig_new(9) & '0' & dig_new(4 downto 2));
                            else
                                select_data <= (dig_new(9) & '1' & dig_new(4 downto 2));
                            end if;
                        else
                            if (dig_new(8 downto 5) = x"F") then
                                select_data <= (dig_new(9) & '1' & dig_new(4 downto 2));
                            else
                                select_data <= (dig_new(9) & '0' & dig_new(4 downto 2));
                            end if;
                        end if;
                    else
                        select_data <= dig_new(9 downto 5);
                    end if;
                else
                    select_data <= select_data;
                end if;
            end if;
        end if;
    end	process;

    signed_bit <= select_data(4);
    -- the negitive number here is the 2's complement - 1
    process(signed_bit)
    begin
        if (signed_bit = '1') then
            abs_select_high <= not select_data(3 downto 0); 
        else
            abs_select_high <= select_data(3 downto 0);
        end if;
    end process;

    --oLED bus  ////////////////
    process(iCLK)
    begin
        if (rising_edge(iCLK)) then 
            if (iRSTN = '0') then 
                oLED1 <= x"00";
            else
                if (det_dig_offset = '1') then
                    oLED1 <= ("0000000" & dig_offset_dcnt(9));--{8{dig_offset_dcnt(9)}} ;
                else
                    if (led_upd = '1') then
                        -- synopsys parallel_case
                        if ((abs_select_high(3 downto 0) = "1110") OR (abs_select_high(3 downto 0) = "1111")) then
                            oLED1 <= "00011000" ;
                        elsif (abs_select_high(3 downto 0) = "1101") then
                            if (signed_bit = '1') then
                                oLED1 <= "00010000";
                            else
                                oLED1 <= "00001000";
                            end if;
                        elsif (abs_select_high(3 downto 0) = "1100") then
                            if (signed_bit = '1') then
                                oLED1 <= "00100000";
                            else
                                oLED1 <= "00000100";
                            end if;
                        elsif (abs_select_high(3 downto 0) = "1011") then
                            if (signed_bit = '1') then
                                oLED1 <= "01000000";
                            else
                                oLED1 <= "00000010";
                            end if;
                        elsif (abs_select_high(3 downto 0) = "1001") then
                            if (signed_bit = '1') then
                                oLED1 <= "10000000";
                            else
                                oLED1 <= "00000001" ;
                            end if;
                        else --'U', 'X', '-', etc.
                            if (signed_bit = '1') then
                                oLED1 <= "10000000";
                            else
                                oLED1 <= "00000001";
                            end if;
                        end if;
                    else
                        oLED <= oLED1 ;
                    end if;
                end if;
            end if;
        end if;
    end	process;
end rtl;
