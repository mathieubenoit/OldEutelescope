--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:40:01 04/19/2013
-- Design Name:   
-- Module Name:   C:/Users/mbenoit/Documents/FPGA_Projects/MIMTLU/pcores/mimtlu_v1_00_a/devl/projnav/tb.vhd
-- Project Name:  mimtlu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         test : IN  std_logic;
         CLOCK_Y3 : IN  std_logic;
         TRIGGER_DUT : OUT  std_logic;
         BUSY_DUT : IN  std_logic;
         TRIGGER_COPY : OUT  std_logic;
         BUSY_COPY : OUT  std_logic;
         DATA_ITR : OUT  std_logic;
         timestamp : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal test : std_logic := '0';
   signal CLOCK_Y3 : std_logic := '0';
   signal BUSY_DUT : std_logic := '0';

 	--Outputs
   signal TRIGGER_DUT : std_logic;
   signal TRIGGER_COPY : std_logic;
   signal BUSY_COPY : std_logic;
   signal DATA_ITR : std_logic;
   signal timestamp : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLOCK_Y3_period : time := 10 ns;
   constant USER_CLOCK_period : time := 25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          test => test,
          CLOCK_Y3 => CLOCK_Y3,
          TRIGGER_DUT => TRIGGER_DUT,
          BUSY_DUT => BUSY_DUT,
          TRIGGER_COPY => TRIGGER_COPY,
          BUSY_COPY => BUSY_COPY,
          DATA_ITR => DATA_ITR,
          timestamp => timestamp
        );

   -- Clock process definitions
   CLOCK_Y3_process :process
   begin
		CLOCK_Y3 <= '0';
		wait for CLOCK_Y3_period/2;
		CLOCK_Y3 <= '1';
		wait for CLOCK_Y3_period/2;
   end process;

	
	
	process 
	begin 
	
		wait for 10 ns;
		
		test <='1';
		
		wait for 1000 ns;
		
		
		test <='0';

		wait for 1000 ns;
		
		test <='1';
		
		wait for 1000 ns;
		
		
		test <='0';

		wait for 1000 ns;
		test <='1';
		
		wait for 1000 ns;
		
		
		test <='0';

		wait for 1000 ns;
		test <='1';
		
		wait for 1000 ns;
		
		
		test <='0';

		wait for 1000 ns;
		test <='1';
		
		wait for 1000 ns;
		
		
		test <='0';
		wait for 1000 ns;		
end process;

END;
