----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:50:34 02/22/2013 
-- Design Name: 
-- Module Name:    TLU_SM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.

entity MIMTLU_core is
	 Generic ( Nbits : integer );
    Port ( Trigger : in  STD_LOGIC;
           busy : out  STD_LOGIC;
			  
			  trigger_copy : out STD_LOGIC;
			  trigger_dut : out STD_LOGIC;
			  
			  busy_copy : out STD_LOGIC;
			  busy_dut : in STD_LOGIC;
			  
			  reset : in STD_LOGIC;
			  timestamp : out STD_LOGIC_VECTOR(31 downto 0);
			  busy_cnt : in STD_LOGIC_VECTOR(31 downto 0);
           clk : in  STD_LOGIC;
			  data_itr : out  STD_LOGIC;
			  clk_out_en : out STD_LOGIC);
end MIMTLU_core;

architecture Behavioral of MIMTLU_core is

type TLU_state is (idle,triggered,reading,isBusy);
type ts is range 0 to 31;

constant ts_length : ts:=ts(Nbits);
signal ts_cnt : ts;
signal state_reg,state_next : TLU_state;

signal timestamp_reg : std_logic_vector(Nbits downto 0);

signal busy_reg : std_logic:='0';
signal clk_en_reg : std_logic:='0';
signal busy_dut_reg : std_logic:='0';

signal read_en : std_logic:='0';
signal index : integer:=0;

signal ts_reg : std_logic:='0';

signal data_itr_reg : std_logic:='0';


signal count : natural ;

signal wait_time : natural := 255;


begin

REG:process(clk,reset,busy_reg)
begin 

if (reset='1') then 
	state_reg <= idle; 
	count<=0;
	ts_cnt<=0;
	
elsif rising_edge(clk) then 
	state_reg <= state_next;
	busy_dut_reg<=busy_dut;
	if(ts_cnt=ts_length and clk_en_reg='1') then 
		timestamp_reg(natural(ts_cnt))<=ts_reg;
		ts_cnt<=0;
		data_itr_reg<='1';
	elsif(clk_en_reg='1') then 
		timestamp_reg(natural(ts_cnt))<=ts_reg;
		ts_cnt<=ts_cnt+1;
		data_itr_reg<='0';

		
	else
			data_itr_reg<='0';
	end if;
	
	if(count=wait_time and busy_reg='1') then 
		count<=0;
	elsif(busy_reg='1') then 
		count<=count+1;
	else
	end if;
end if;

end process REG;

SM:process(trigger,state_reg,read_en,clk_en_reg,count,ts_cnt,timestamp_reg)

begin 

case state_reg is 
	when idle =>
		if trigger='1' then
			state_next <= triggered;
		else
			state_next<= idle;
		end if;
		busy_reg<='0';
		clk_en_reg<='0';
		ts_reg<='0';

	
	when triggered =>
			busy_reg<='1';
			clk_en_reg<='0';
	   	state_next<=reading;
			ts_reg<='0';

			
	
	when reading =>
			clk_en_reg<='1';
			busy_reg<='1';
			ts_reg<=trigger;
			if(ts_cnt=ts_length) then 
				state_next<=isbusy;
			else
				state_next<=reading;
			end if;
			
	when isbusy =>
			busy_reg<='1';
			clk_en_reg<='0';
			ts_reg<='0';
			if (count=wait_time) then 
				state_next<=idle;
			else 
				state_next<=isbusy;
			end if;
				
end case;

end process SM;

busy <= busy_reg or busy_dut_reg;

trigger_dut <= trigger when clk_en_reg='0' else
             '0' ;

busy_copy<=busy_reg or busy_dut_reg;
trigger_copy<=trigger;

timestamp(31 downto Nbits+1)<=(others=>'0');
timestamp(Nbits downto 0)<=timestamp_reg;

data_itr<=data_itr_reg;

wait_time<=to_integer(unsigned(busy_cnt(31 downto 0)));


clk_out_en<=clk_en_reg;

end Behavioral;

