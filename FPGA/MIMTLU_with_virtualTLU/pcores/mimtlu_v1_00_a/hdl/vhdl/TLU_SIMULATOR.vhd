----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:33 11/20/2012 
-- Design Name: 
-- Module Name:    TLU_SIMU - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity TLU_SIMU is
    Port ( trigger : out  STD_LOGIC;
           busy : in  STD_LOGIC;
			  test : in STD_LOGIC;
           reset : in  STD_LOGIC;
			  clk_int : in std_logic;
           clk : in  STD_LOGIC);
end TLU_SIMU;

architecture Behavioral of TLU_SIMU is

type TLU_state is (idle,triggered,isBusy);
type small_int is range 0 to 15;

signal state_reg,state_next : TLU_state;
signal output_dis,test_reg,busy_reg : STD_LOGIC;
signal trigger_reg : STD_LOGIC;
signal timestamp: unsigned(15 downto 0):=(others=>'0');
signal cnt : small_int;

signal edge1,edge2 : STD_LOGIC :='0';

begin

TLUSIMSM:process(state_reg,busy,test_reg,busy_reg,output_dis,timestamp,cnt)

begin 

case state_reg is 
	when idle =>
		trigger_reg<='0';
		if (test_reg='1' and busy_reg='0') then
			state_next <= triggered;
		else
			state_next<= idle;
		end if;
	
	when triggered =>
		trigger_reg<='1';
		if busy='1' then
			state_next <= isbusy;
		else
			state_next<= triggered;
		end if;			
	
			
	when isbusy =>
			trigger_reg<='0';
			if(output_dis='0') then 
				state_next<=isbusy;
				trigger_reg<=timestamp(natural(cnt));
				
			else
				state_next<=idle;
			end if;
				
end case;

end process TLUSIMSM;



REG:process(clk,clk_int,reset,output_dis,state_reg,timestamp,cnt)

begin 

output_dis<='0';

if (reset='1') then 
	state_reg <= idle; 
	timestamp <= (others => '0');
	output_dis<='0';
	--cnt<=0;
	
elsif rising_edge(clk_int) then 
	state_reg <= state_next;
	timestamp<=timestamp;
	output_dis<=output_dis;

	if(state_reg=isbusy and output_dis='0' and cnt=15) then 
		output_dis<='1';
		timestamp<=timestamp+1;		
	elsif (state_reg=isbusy and output_dis='0') then 
		output_dis<='0';
		timestamp<=timestamp;
	else
		output_dis<='0';
		timestamp<=timestamp;
	end if;	

else 
	output_dis<=output_dis;
	state_reg<=state_reg;
	timestamp<=timestamp;	

end if;

if rising_edge(clk) then 
		
	if (state_reg=isbusy and output_dis='0') then 
		cnt<=cnt+1; 
		--output_dis<='0';
		--timestamp<=timestamp;
	else
		--output_dis<='0';
		cnt<=0;
		--timestamp<=timestamp;
	end if;
	
else
	--output_dis<=output_dis;
	--state_reg<=state_reg;
	--timestamp<=timestamp;
	cnt<=cnt;
	
end if;

end process REG;


nedgedetector : process(test,clk_int, reset)
  --edge1:='1';
  --edge2:='1';
  begin
    if reset = '1' then
      edge1 <= '0';
      edge2 <= '0';
    elsif clk_int'event and clk_int = '1' then
      edge1 <= test;
      edge2 <= edge1;
    end if;
  end process nedgedetector;


test_reg <= '1' when (edge1 = '1' and edge2 = '0') else
          '0';


--test_reg <= sig1 xor sig2;




--test_reg<=test;
TRIG : trigger<=trigger_reg;
busy_reg<=busy;

end Behavioral;

