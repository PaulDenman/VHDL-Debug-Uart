--------------------------------------------------------------------------------
--DebugUart by Paul Denman
--info_data_1 to 10 will print a hex value to a uart. There is a fifo to store transistions that are faster than the uart output.
--
--The basic uart design I think comes from a book by Prof. Lizy John and Prof. Charles Roth 
--This works with the Tang Nano
---------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

 
library machxo2;
use machxo2.all;

entity DebugUart is

  generic (	
            baud_divider : positive := 234  --divide to baud rate from sys clock 27Mhz	
          );

	
port (	 
pld_rst_l               : in std_logic;
sys_clk                 : in std_logic;                     
tp_1                    : in std_logic;                     
tp_2                    : in std_logic;   --Tang Nano reset switch                  
uart_cpld_sout          : out std_logic 
);
end DebugUart;



architecture DebugUart_arch of DebugUart is

  signal clk_out_baud  	: std_logic;
  signal uart_load_tdr  	: std_logic;
  signal uart_load_tdre  	: std_logic;
  signal info_data_1	  	: std_logic_vector(7 downto 0);
	signal info_data_2    	: std_logic_vector(7 downto 0);
	signal info_data_3    	: std_logic_vector(7 downto 0);
	signal info_data_4    	: std_logic_vector(7 downto 0);
	signal info_data_5    	: std_logic_vector(7 downto 0);
	signal info_data_6    	: std_logic_vector(7 downto 0);
	signal info_data_7    	: std_logic_vector(7 downto 0);
	signal info_data_8    	: std_logic_vector(7 downto 0); 
	signal info_data_9    	: std_logic_vector(7 downto 0); 
	signal info_data_10    	: std_logic_vector(7 downto 0); 
	signal clockdiv_baud 	: natural range 0 to baud_divider := 0;    -- clock divide counter    



	component  uart_transmitter
		port(bclk, sysclk, rst_b : in std_logic;
			dbus_1:in std_logic_vector(7 downto 0);
			dbus_2:in std_logic_vector(7 downto 0);
			dbus_3:in std_logic_vector(7 downto 0);
			dbus_4:in std_logic_vector(7 downto 0);
			dbus_5:in std_logic_vector(7 downto 0);
			dbus_6:in std_logic_vector(7 downto 0);
			dbus_7:in std_logic_vector(7 downto 0);
			dbus_8:in std_logic_vector(7 downto 0);
			dbus_9:in std_logic_vector(7 downto 0);		
			dbus_10:in std_logic_vector(7 downto 0);
			txd: out std_logic);
	end component;


begin
  info_data_1 <= "1111111"&tp_1;     --Example values
  info_data_2 <= "1111"&tp_2&"100"; 
  info_data_3 <= "11111010"; 
  info_data_4 <= "11110110"; 
  info_data_5 <= "11101110"; 
  info_data_6 <= "11011110"; 
  info_data_7 <= x"DE";
  info_data_8 <= x"AD";
  info_data_9 <= x"BE";
  info_data_10 <=x"EF";

  clock_div_baud_p : process (sys_clk, pld_rst_l) is
  begin  -- process clock_div_p
    if pld_rst_l = '0' then                 
      clockdiv_baud <= 0;
      clk_out_baud  <= '0';
    elsif sys_clk'event and sys_clk = '1' then  
      if (clockdiv_baud = baud_divider) then    
        clockdiv_baud <= 0;
        clk_out_baud <= '1';
      else
        clk_out_baud <='0';
        clockdiv_baud <= clockdiv_baud +1;
      end if;
    end if;
  end process clock_div_baud_p; 

	uart_tx_i : uart_transmitter port map  
		(bclk 		=>	clk_out_baud,
		 sysclk		=>	sys_clk,
		 rst_b		=>	pld_rst_l,
		 dbus_1	    	=>	info_data_1,
	 	 dbus_2	    	=>	info_data_2,
	 	 dbus_3	    	=>	info_data_3,
	 	 dbus_4	    	=>	info_data_4,
	 	 dbus_5	    	=>	info_data_5,
	 	 dbus_6	    	=>	info_data_6,
	 	 dbus_7	    	=>	info_data_7,
	 	 dbus_8	    	=>	info_data_8,
	 	 dbus_9	    	=>	info_data_9,
	 	 dbus_10    	=>	info_data_10,
		 txd		      =>	uart_cpld_sout
     );     
end architecture DebugUart_arch;

