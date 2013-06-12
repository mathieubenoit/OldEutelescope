----------------------------------------------------------------------------------
-- Company: CERN
-- Engineer: Mathieu Benoit
-- 
-- Create Date:    17:13:44 11/20/2012 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

library mimtlu_v1_00_a;
use mimtlu_v1_00_a.all;

entity top is
    Port ( 
			  CLOCK_Y3 : in STD_LOGIC;

			  TRIGGER_P : in std_logic;
			  TRIGGER_N : in std_logic;
			  TRIGGER_CLOCK_P : out std_logic;
			  TRIGGER_CLOCK_N : out std_logic;	
			  BUSY_P : out STD_LOGIC ;		
			  BUSY_N : out STD_LOGIC ;					  
			  RESET_P : in STD_LOGIC ;		
			  RESET_N : in STD_LOGIC ;		
			  
			  TRIGGER_DUT : out std_logic;
			  BUSY_DUT : in std_logic;
			  TRIGGER_COPY : out std_logic;
			  BUSY_COPY : out std_logic;
			  
			  DATA_ITR : out std_logic;
			  
			  BUSY_CNT : in std_logic_vector(31 downto 0);
			  BUSY_HANDLE : in std_logic_vector(31 downto 0);
			  timestamp : out std_logic_vector(31 downto 0));
end top;

architecture Behavioral of top is

signal clk_en : STD_LOGIC;
signal trigger, busy,reset, clk_out : STD_LOGIC;

signal SLOW_CLK : STD_LOGIC;

begin



BUFGCE_inst : BUFGCE port map ( O=>clk_out,CE=>clk_en,I=>SLOW_CLK );

-- Input buffers for TLU LVDS Signals

IBUFDS_TRIGGER : IBUFDS
   generic map (
      DIFF_TERM => TRUE, -- Differential Termination 
      IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "LVDS_33")
   port map (
      O => TRIGGER,  -- Buffer output
      I => TRIGGER_P,  -- Diff_p buffer input (connect directly to top-level port)
      IB => TRIGGER_N -- Diff_n buffer input (connect directly to top-level port)
   );

IBUFDS_RESET : IBUFDS
   generic map (
      DIFF_TERM => TRUE, -- Differential Termination 
      IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "LVDS_33")
   port map (
      O => RESET,  -- Buffer output
      I => RESET_P,  -- Diff_p buffer input (connect directly to top-level port)
      IB => RESET_N -- Diff_n buffer input (connect directly to top-level port)
   );	
	
---- Output buffers for TLU LVDS Signals
--	
OBUFDS_BUSY : entity mimtlu_v1_00_a.dummy_diffpair
   port map (
      O => BUSY_P,     -- Diff_p output (connect directly to top-level port)
      OB => BUSY_N,   -- Diff_n output (connect directly to top-level port)
      I => BUSY     -- Buffer input 
   );


OBUFDS_TRIGGER_CLOCK :  entity mimtlu_v1_00_a.dummy_diffpair
   port map (
      O => TRIGGER_CLOCK_P,     -- Diff_p output (connect directly to top-level port)
      OB => TRIGGER_CLOCK_N,   -- Diff_n output (connect directly to top-level port)
      I => clk_out      -- Buffer input 
   );	
	


-- TLU Man-In-The-Middle	

TLU_READ : entity work.MIMTLU_core generic map(Nbits =>31) 
											port map(trigger=>TRIGGER,
													busy=>BUSY,
													reset=>RESET,
													timestamp=>timestamp,
													BUSY_HANDLE=>busy_handle,
													BUSY_CNT=>BUSY_CNT,
													clk=>SLOW_CLK,
													data_itr=>DATA_ITR,
													busy_dut=>busy_dut,
													busy_copy=>busy_copy,
													trigger_dut=>trigger_dut,
													trigger_copy=>trigger_copy,													
													clk_out_en=>clk_en);
													
--TLU_SIM : entity work.TLU_SIMU 	generic map(Nbits =>31)
--											port map(trigger=>trigger,
--													busy=>busy,
--													test=>test,
--													reset=>reset,
--													clk_int=>SLOW_CLK,
--													clk=>clk_out);


CLK_DIV : entity work.clk_divider 
											port map(	clk_in  => CLOCK_Y3,
															reset   => reset,
															clk_out => SLOW_CLK);

--SLOW_CLK<=CLOCK_Y3;

end Behavioral;


