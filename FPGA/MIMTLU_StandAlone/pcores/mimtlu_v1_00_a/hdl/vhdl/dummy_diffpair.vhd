----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:50 05/02/2013 
-- Design Name: 
-- Module Name:    dummy_diffpair - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity dummy_diffpair is
    Port ( I : in  STD_LOGIC;
           O : out  STD_LOGIC;
           OB : out  STD_LOGIC);
end dummy_diffpair;

architecture Behavioral of dummy_diffpair is

begin
	
	O<=I;
	OB<= not I;

end Behavioral;

