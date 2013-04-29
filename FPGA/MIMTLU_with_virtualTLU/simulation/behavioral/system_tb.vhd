-------------------------------------------------------------------------------
-- system_tb.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

-- START USER CODE (Do not remove this line)

-- User: Put your libraries here. Code in this
--       section will not be overwritten.

-- END USER CODE (Do not remove this line)

entity system_tb is
end system_tb;

architecture STRUCTURE of system_tb is

  constant CLK_66MHZ_PERIOD : time := 14999.999925 ps;
  constant CLK_Y3_PERIOD : time := 10ns;
  constant USER_CLOCK_PERIOD : time := 10 ns;

  constant RESET_LENGTH : time := 240000 ps;

  component system is
    port (
      rzq : inout std_logic;
      mcbx_dram_we_n : out std_logic;
      mcbx_dram_udqs : inout std_logic;
      mcbx_dram_udm : out std_logic;
      mcbx_dram_ras_n : out std_logic;
      mcbx_dram_ldm : out std_logic;
      mcbx_dram_dqs : inout std_logic;
      mcbx_dram_dq : inout std_logic_vector(15 downto 0);
      mcbx_dram_clk_n : out std_logic;
      mcbx_dram_clk : out std_logic;
      mcbx_dram_cke : out std_logic;
      mcbx_dram_cas_n : out std_logic;
      mcbx_dram_ba : out std_logic_vector(1 downto 0);
      mcbx_dram_addr : out std_logic_vector(12 downto 0);
      USB_Uart_sout : out std_logic;
      USB_Uart_sin : in std_logic;
      RESET : in std_logic;
      LEDs_4Bits_TRI_O : out std_logic_vector(3 downto 0);
      Ethernet_MAC_TX_EN : out std_logic;
      Ethernet_MAC_TX_CLK : in std_logic;
      Ethernet_MAC_TXD : out std_logic_vector(3 downto 0);
      Ethernet_MAC_RX_ER : in std_logic;
      Ethernet_MAC_RX_DV : in std_logic;
      Ethernet_MAC_RX_CLK : in std_logic;
      Ethernet_MAC_RXD : in std_logic_vector(3 downto 0);
      Ethernet_MAC_PHY_RST_N : out std_logic;
      Ethernet_MAC_MDIO : inout std_logic;
      Ethernet_MAC_MDC : out std_logic;
      Ethernet_MAC_CRS : in std_logic;
      Ethernet_MAC_COL : in std_logic;
      DIP_Switches_4Bits_TRI_I : in std_logic_vector(3 downto 0);
      CLK_66MHZ : in std_logic;
      mimtlu_0_TEST_pin : in std_logic;
      mimtlu_0_CLOCK_Y2_pin : in std_logic;
      mimtlu_0_BUSY_DUT_pin : in std_logic;
      mimtlu_0_USER_CLOCK_pin : in std_logic;
      mimtlu_0_TRIGGER_DUT_pin : out std_logic;
      mimtlu_0_TRIGGER_COPY_pin : out std_logic;
      mimtlu_0_BUSY_COPY_pin : out std_logic;
      mimtlu_0_CLOCK_Y3_pin : in std_logic
    );
  end component;

  -- Internal signals

  signal CLK_66MHZ : std_logic;
  signal DIP_Switches_4Bits_TRI_I : std_logic_vector(3 downto 0);
  signal Ethernet_MAC_COL : std_logic;
  signal Ethernet_MAC_CRS : std_logic;
  signal Ethernet_MAC_MDC : std_logic;
  signal Ethernet_MAC_MDIO : std_logic;
  signal Ethernet_MAC_PHY_RST_N : std_logic;
  signal Ethernet_MAC_RXD : std_logic_vector(3 downto 0);
  signal Ethernet_MAC_RX_CLK : std_logic;
  signal Ethernet_MAC_RX_DV : std_logic;
  signal Ethernet_MAC_RX_ER : std_logic;
  signal Ethernet_MAC_TXD : std_logic_vector(3 downto 0);
  signal Ethernet_MAC_TX_CLK : std_logic;
  signal Ethernet_MAC_TX_EN : std_logic;
  signal LEDs_4Bits_TRI_O : std_logic_vector(3 downto 0);
  signal RESET : std_logic;
  signal USB_Uart_sin : std_logic;
  signal USB_Uart_sout : std_logic;
  signal mcbx_dram_addr : std_logic_vector(12 downto 0);
  signal mcbx_dram_ba : std_logic_vector(1 downto 0);
  signal mcbx_dram_cas_n : std_logic;
  signal mcbx_dram_cke : std_logic;
  signal mcbx_dram_clk : std_logic;
  signal mcbx_dram_clk_n : std_logic;
  signal mcbx_dram_dq : std_logic_vector(15 downto 0);
  signal mcbx_dram_dqs : std_logic;
  signal mcbx_dram_ldm : std_logic;
  signal mcbx_dram_ras_n : std_logic;
  signal mcbx_dram_udm : std_logic;
  signal mcbx_dram_udqs : std_logic;
  signal mcbx_dram_we_n : std_logic;
  signal mimtlu_0_BUSY_COPY_pin : std_logic;
  signal mimtlu_0_BUSY_DUT_pin : std_logic;
  signal mimtlu_0_CLOCK_Y2_pin : std_logic;
  signal mimtlu_0_CLOCK_Y3_pin : std_logic;
  signal mimtlu_0_TEST_pin : std_logic;
  signal mimtlu_0_TRIGGER_COPY_pin : std_logic;
  signal mimtlu_0_TRIGGER_DUT_pin : std_logic;
  signal mimtlu_0_USER_CLOCK_pin : std_logic;
  signal rzq : std_logic;

  -- START USER CODE (Do not remove this line)

  -- User: Put your signals here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

begin

  dut : system
    port map (
      rzq => rzq,
      mcbx_dram_we_n => mcbx_dram_we_n,
      mcbx_dram_udqs => mcbx_dram_udqs,
      mcbx_dram_udm => mcbx_dram_udm,
      mcbx_dram_ras_n => mcbx_dram_ras_n,
      mcbx_dram_ldm => mcbx_dram_ldm,
      mcbx_dram_dqs => mcbx_dram_dqs,
      mcbx_dram_dq => mcbx_dram_dq,
      mcbx_dram_clk_n => mcbx_dram_clk_n,
      mcbx_dram_clk => mcbx_dram_clk,
      mcbx_dram_cke => mcbx_dram_cke,
      mcbx_dram_cas_n => mcbx_dram_cas_n,
      mcbx_dram_ba => mcbx_dram_ba,
      mcbx_dram_addr => mcbx_dram_addr,
      USB_Uart_sout => USB_Uart_sout,
      USB_Uart_sin => USB_Uart_sin,
      RESET => RESET,
      LEDs_4Bits_TRI_O => LEDs_4Bits_TRI_O,
      Ethernet_MAC_TX_EN => Ethernet_MAC_TX_EN,
      Ethernet_MAC_TX_CLK => Ethernet_MAC_TX_CLK,
      Ethernet_MAC_TXD => Ethernet_MAC_TXD,
      Ethernet_MAC_RX_ER => Ethernet_MAC_RX_ER,
      Ethernet_MAC_RX_DV => Ethernet_MAC_RX_DV,
      Ethernet_MAC_RX_CLK => Ethernet_MAC_RX_CLK,
      Ethernet_MAC_RXD => Ethernet_MAC_RXD,
      Ethernet_MAC_PHY_RST_N => Ethernet_MAC_PHY_RST_N,
      Ethernet_MAC_MDIO => Ethernet_MAC_MDIO,
      Ethernet_MAC_MDC => Ethernet_MAC_MDC,
      Ethernet_MAC_CRS => Ethernet_MAC_CRS,
      Ethernet_MAC_COL => Ethernet_MAC_COL,
      DIP_Switches_4Bits_TRI_I => DIP_Switches_4Bits_TRI_I,
      CLK_66MHZ => CLK_66MHZ,
      mimtlu_0_TEST_pin => mimtlu_0_TEST_pin,
      mimtlu_0_CLOCK_Y2_pin => mimtlu_0_CLOCK_Y2_pin,
      mimtlu_0_BUSY_DUT_pin => mimtlu_0_BUSY_DUT_pin,
      mimtlu_0_USER_CLOCK_pin => mimtlu_0_USER_CLOCK_pin,
      mimtlu_0_TRIGGER_DUT_pin => mimtlu_0_TRIGGER_DUT_pin,
      mimtlu_0_TRIGGER_COPY_pin => mimtlu_0_TRIGGER_COPY_pin,
      mimtlu_0_BUSY_COPY_pin => mimtlu_0_BUSY_COPY_pin,
      mimtlu_0_CLOCK_Y3_pin => mimtlu_0_CLOCK_Y3_pin
    );

  -- Clock generator for CLK_66MHZ

  mimtlu_0_BUSY_DUT_pin<='0';

  process
  begin
    CLK_66MHZ <= '0';
    loop
      wait for (CLK_66MHZ_PERIOD/2);
      CLK_66MHZ <= not CLK_66MHZ;
    end loop;
  end process;
  process
  begin
    mimtlu_0_CLOCK_Y3_pin <= '0';
    loop
      wait for (CLK_Y3_PERIOD/2);
      mimtlu_0_CLOCK_Y3_pin <= not mimtlu_0_CLOCK_Y3_pin;
    end loop;
  end process;
  process
  begin
    mimtlu_0_USER_CLOCK_pin <= '0';
    loop
      wait for (USER_CLOCK_PERIOD/2);
      mimtlu_0_USER_CLOCK_pin <= not mimtlu_0_USER_CLOCK_pin;
    end loop;
  end process;

  -- Reset Generator for RESET

  process
  begin
    RESET <= '1';
    wait for (RESET_LENGTH);
    RESET <= not RESET;
    wait;
  end process;
  
  process
   begin 

  reset<='1'; 
  wait for 10 ns;
  reset<='0';
  
  
  mimtlu_0_TEST_pin<='1';
  
  wait for 1 us; 
  
  mimtlu_0_TEST_pin<='0';
  
  wait for 5 us;
  
  mimtlu_0_TEST_pin<='1';
  
  wait for 1 us; 
  
  mimtlu_0_TEST_pin<='0';
  
  wait for 5 us;
 
 mimtlu_0_TEST_pin<='1';
  
  wait for 1 us; 
  
  mimtlu_0_TEST_pin<='0';
  
  wait for 5 us;
  
  mimtlu_0_TEST_pin<='1';
  
  wait for 1 us; 
  
  mimtlu_0_TEST_pin<='0';
  
  wait for 5 us;
   
	mimtlu_0_TEST_pin<='1';
  
  wait for 1 us; 
  
  mimtlu_0_TEST_pin<='0';
  
  wait for 5 us;
  
  end process;

  -- START USER CODE (Do not remove this line)

  -- User: Put your stimulus here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

end architecture STRUCTURE;

