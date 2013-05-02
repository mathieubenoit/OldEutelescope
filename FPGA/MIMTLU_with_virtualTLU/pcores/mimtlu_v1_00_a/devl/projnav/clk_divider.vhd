----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:19 04/25/2013 
-- Design Name: 
-- Module Name:    clk_divider - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity clk_divider is
	Port (
        clk_in : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clk_divider;

architecture Behavioral of clk_divider is

signal temporal: STD_LOGIC:='0';
signal unbuf_clk : std_logic:='0';
signal counter : integer range 0 to 4 := 0;

begin
    frequency_divider: process (reset, clk_in) begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk_in) then
            if (counter = 4) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
		  
		  
end process;
    
    unbuf_clk <= temporal;
	 
BUFG_inst : BUFG
   port map (
      O => clk_out, -- 1-bit output: Clock buffer output
      I => unbuf_clk  -- 1-bit input: Clock buffer input
   );
	 
end Behavioral;
