library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity tb_vga is
end tb_vga;

architecture testing_tb of tb_vga is

component vga is
 GENERIC (
  Ha: INTEGER := 96; --Hpulse
  Hb: INTEGER := 144; --Hpulse+HBP
  Hc: INTEGER := 784; --Hpulse+HBP+Hactive
  Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
  Va: INTEGER := 2; --Vpulse
  Vb: INTEGER := 35; --Vpulse+VBP
  Vc: INTEGER := 515; --Vpulse+VBP+Vactive
  Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
------------------------------------------------  
 PORT (
       clk         : IN STD_LOGIC; --50MHz in our board
       red_switch, green_switch, blue_switch: IN STD_LOGIC;
       pixel_clk   : OUT STD_LOGIC;
       Hsync, Vsync: BUFFER STD_LOGIC;
       R, G, B     : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
       nblanck, nsync : OUT STD_LOGIC);
end component;
----------------------------------------------------------
signal	clk_tb        :  STD_LOGIC:='1';
signal	red_sw_tb     :  STD_LOGIC:='1';
signal	green_sw_tb   :  STD_LOGIC:='1';
signal	blue_sw_tb    :  STD_LOGIC:='1';
signal  pixel_clk_tb  :  STD_LOGIC;
signal  hsync_tb      :  STD_LOGIC:='0';
signal  vsync_tb      :  STD_LOGIC:='0';
signal  nblanck_tb    :  STD_LOGIC:='0';
signal  nsync_tb      :  STD_LOGIC:='0';
signal	R_tb          :  STD_LOGIC_VECTOR (9 downto 0);
signal	G_tb          :  STD_LOGIC_VECTOR (9 downto 0);
signal	B_tb          :  STD_LOGIC_VECTOR (9 downto 0);
constant clk_period:time := 20ns;
-------------------------------------------------------
begin
UUT:vga PORT MAP
(        
          clk           => clk_tb, 
          red_switch    => red_sw_tb,  
		  green_switch  => green_sw_tb,
		  blue_switch   => blue_sw_tb,
		  pixel_clk     => pixel_clk_tb,  
		  Hsync         => hsync_tb,
          Vsync         => vsync_tb,
          R             => R_tb,    
          G             => G_tb,
		  B             => B_tb,
		  nblanck       => nblanck_tb,
		  nsync         => nsync_tb   		  
		  	);
------------------------------------------
			-- Clock Gen
		process(clk_tb)
		begin 
		clk_tb <= not clk_tb after clk_period/2 ;
		end process;
-------------------------------------------------
rgb_test : process --stimulus
begin
     red_sw_tb   <= '1'; 
	 green_sw_tb <= '0';
	 blue_sw_tb  <= '0';
     wait for 500 ns;
	 
     red_sw_tb   <= '0'; 
	 green_sw_tb <= '1';
	 blue_sw_tb  <= '1';
     wait for 800 ns;
          
end process;
				
end testing_tb;
		