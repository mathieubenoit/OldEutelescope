-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
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
    mimtlu_0_BUSY_DUT_pin : in std_logic;
    mimtlu_0_TRIGGER_DUT_pin : out std_logic;
    mimtlu_0_TRIGGER_COPY_pin : out std_logic;
    mimtlu_0_BUSY_COPY_pin : out std_logic;
    mimtlu_0_TRIGGER_P_pin : in std_logic;
    mimtlu_0_TRIGGER_N_pin : in std_logic;
    mimtlu_0_RESET_P_pin : in std_logic;
    mimtlu_0_RESET_N_pin : in std_logic;
    mimtlu_0_BUSY_P_pin : out std_logic;
    mimtlu_0_BUSY_N_pin : out std_logic;
    mimtlu_0_TRIGGER_CLOCK_P_pin : out std_logic;
    mimtlu_0_TRIGGER_CLOCK_N_pin : out std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

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
      mimtlu_0_BUSY_DUT_pin : in std_logic;
      mimtlu_0_TRIGGER_DUT_pin : out std_logic;
      mimtlu_0_TRIGGER_COPY_pin : out std_logic;
      mimtlu_0_BUSY_COPY_pin : out std_logic;
      mimtlu_0_TRIGGER_P_pin : in std_logic;
      mimtlu_0_TRIGGER_N_pin : in std_logic;
      mimtlu_0_RESET_P_pin : in std_logic;
      mimtlu_0_RESET_N_pin : in std_logic;
      mimtlu_0_BUSY_P_pin : out std_logic;
      mimtlu_0_BUSY_N_pin : out std_logic;
      mimtlu_0_TRIGGER_CLOCK_P_pin : out std_logic;
      mimtlu_0_TRIGGER_CLOCK_N_pin : out std_logic
    );
  end component;

  attribute BUFFER_TYPE : STRING;
  attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of Ethernet_MAC_TX_CLK : signal is "IBUF";
  attribute BUFFER_TYPE of Ethernet_MAC_RX_CLK : signal is "IBUF";
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
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
      mimtlu_0_BUSY_DUT_pin => mimtlu_0_BUSY_DUT_pin,
      mimtlu_0_TRIGGER_DUT_pin => mimtlu_0_TRIGGER_DUT_pin,
      mimtlu_0_TRIGGER_COPY_pin => mimtlu_0_TRIGGER_COPY_pin,
      mimtlu_0_BUSY_COPY_pin => mimtlu_0_BUSY_COPY_pin,
      mimtlu_0_TRIGGER_P_pin => mimtlu_0_TRIGGER_P_pin,
      mimtlu_0_TRIGGER_N_pin => mimtlu_0_TRIGGER_N_pin,
      mimtlu_0_RESET_P_pin => mimtlu_0_RESET_P_pin,
      mimtlu_0_RESET_N_pin => mimtlu_0_RESET_N_pin,
      mimtlu_0_BUSY_P_pin => mimtlu_0_BUSY_P_pin,
      mimtlu_0_BUSY_N_pin => mimtlu_0_BUSY_N_pin,
      mimtlu_0_TRIGGER_CLOCK_P_pin => mimtlu_0_TRIGGER_CLOCK_P_pin,
      mimtlu_0_TRIGGER_CLOCK_N_pin => mimtlu_0_TRIGGER_CLOCK_N_pin
    );

end architecture STRUCTURE;

