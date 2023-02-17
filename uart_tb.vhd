
-- vhdl test bench 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
--use work.io_utils.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture behavior of testbench is 

	component hub75
	port(
  
  
  pld_rst_l               : in std_logic;
  sys_clk                 : in std_logic;                     --fast system clock
  tp_1                    : in std_logic;                     --fast system clock
  tp_2                    : in std_logic;                     --fast system clock
  uart_cpld_sout          : out std_logic 

		);
	end component;

	signal pld_rst_l           :  std_logic;
	signal sys_clk             :  std_logic;
	signal tp_1                :  std_logic;
	signal tp_2                :  std_logic;
	signal uart_cpld_sout      :  std_logic;
  constant period  : time := 15.1500 ns;	 --8.192mhz

 
begin

-- please check and add your generic clause manually
	uut: hub75 port map(
		pld_rst_l      => pld_rst_l     ,
		sys_clk        => sys_clk       ,
		tp_1           => tp_1          ,
		tp_2           => tp_2          ,
		uart_cpld_sout => uart_cpld_sout
	);

    
   	clkk : process
	  begin
	  --  while (not done) loop
	      loop
	      sys_clk <= '0','1' after period/2;
        --tp_1 <= '0','1' after period/10;
	      wait for period;
	    end loop;
	    wait;
	  end process;




-- *** test bench - user defined section ***
tb : process
   --variable a_str : line;
	 --variable a : std_logic_vector(15 downto 0);
	 --variable found_error : boolean := false;
 	 --variable nand_count : integer := 0;
	
begin

 report "*********** testing ************"; 
      pld_rst_l <= '0';
      tp_1 <= '0'; 
      tp_2 <= '0';       
      wait for 1us;
      pld_rst_l <= '1';
      
      wait for 1000 us;  
      tp_1 <= '1';  
      wait for 100 us;       
      tp_1 <= '0';  
      wait for 100 us;       
      tp_2 <= '0';
       wait for 100 us;      
      tp_2 <= '1';      
      wait for 100 us; 
      
      
report "*********** test bench done ************";  
 
  wait;
  
  
	end process;
-- *** end test bench - user defined section ***

end;
