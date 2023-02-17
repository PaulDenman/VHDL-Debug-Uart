library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_Transmitter is

  generic (	
            tick_divider : positive := 27  -- TICK Time from one change info_data_1 to 10 to the next in uS (27MHz). Make less or more to suit need	
          );

  port(Bclk, sysclk, rst_b: in std_logic;
    DBUS_1:in std_logic_vector(7 downto 0);
    DBUS_2:in std_logic_vector(7 downto 0);
    DBUS_3:in std_logic_vector(7 downto 0);
    DBUS_4:in std_logic_vector(7 downto 0);
    DBUS_5:in std_logic_vector(7 downto 0);
    DBUS_6:in std_logic_vector(7 downto 0);
    DBUS_7:in std_logic_vector(7 downto 0);		
    DBUS_8:in std_logic_vector(7 downto 0);		
    DBUS_9:in std_logic_vector(7 downto 0);		
    DBUS_10:in std_logic_vector(7 downto 0);		
    TxD: out std_logic);
  end UART_Transmitter;

  architecture xmit of UART_Transmitter is
    type stateType is (IDLE, SYNCH, TDATA);
    signal state, nextstate : stateType;
    signal TSR : std_logic_vector (8 downto 0); -- Transmit Shift Register
    signal TDR : std_logic_vector(7 downto 0) ; -- Transmit Data Register
    signal Bct: integer range 0 to 9; -- counts number of bits sent
    signal inc, clr, loadTSR, shftTSR, start: std_logic;
    signal Bclk_rising, Bclk_dlayed: std_logic;
    signal DBUS : std_logic_vector(7 downto 0); 
    signal rmux : std_logic_vector(9 downto 0); 
    signal ADDR : std_logic_vector(5 downto 0); 
    signal TICK : std_logic_vector(31 downto 0); 
    signal TICK_counter : std_logic_vector(31 downto 0); 
    signal rmux_nibb : std_logic_vector(3 downto 0); 
    signal rmux_hex : std_logic_vector(7 downto 0); 
    signal rmux_out : std_logic_vector(7 downto 0); 
    signal l_data_d : std_logic_vector(111 downto 0); 
    signal l_data : std_logic_vector(79 downto 0); 
    signal l_data_fifo : std_logic_vector(111 downto 0); 
    signal l_data_t : std_logic_vector(79 downto 0); 
    signal TDRE_i,Add_inc,RangeDone : std_logic;
    signal fifo_wr_en : std_logic; 
    signal fifo_rd_en : std_logic; 
    signal fifo_reset : std_logic; 
    signal fifo_empty : std_logic; 
    signal fifo_full : std_logic; 
    signal uart_busy : std_logic; 
    
    component fifo_top 
      port (
        Data: in  std_logic_vector(111 downto 0); 
        WrClk: in  std_logic; 
        RdClk: in  std_logic; 
        WrEn: in  std_logic; 
        RdEn: in  std_logic; 
        Q: out  std_logic_vector(111 downto 0); 
        Empty: out  std_logic; 
        Full: out  std_logic); 
    end component;
        
    begin
      TxD <= TSR(0);
      TDR <=rmux_out;
      l_data <= DBUS_1&DBUS_2&DBUS_3&DBUS_4&DBUS_5&DBUS_6&DBUS_7&DBUS_8&DBUS_9&DBUS_10;
      

    read_logic: process (rst_b,sysclk)
    begin
      if (rst_b = '0') then
        rmux <= "10" & x"20";  
      elsif (sysclk'event and sysclk = '1') then
        case ADDR is
          when "000000" => rmux <= "10" & x"20";
          when "000001" => rmux <= "10" & x"20";
          when "000010" => rmux <= "00" & l_data_d (111 downto 104);-- DBUS_1;
          when "000011" => rmux <= "01" & l_data_d (111 downto 104);--DBUS_1;
          when "000100" => rmux <= "10" & x"2C";
          when "000101" => rmux <= "00" & l_data_d (103 downto 96);--DBUS_2;
          when "000110" => rmux <= "01" & l_data_d (103 downto 96);--DBUS_2;
          when "000111" => rmux <= "10" & x"2C";    
          when "001000" => rmux <= "00" & l_data_d (95 downto 88);--DBUS_3; 
          when "001001" => rmux <= "01" & l_data_d (95 downto 88);--DBUS_3;
          when "001010" => rmux <= "10" & x"2C";    
          when "001011" => rmux <= "00" & l_data_d (87 downto 80);--DBUS_4;
          when "001100" => rmux <= "01" & l_data_d (87 downto 80);--DBUS_4;
          when "001101" => rmux <= "10" & x"2C";    
          when "001110" => rmux <= "00" & l_data_d (79 downto 72);--DBUS_5;
          when "001111" => rmux <= "01" & l_data_d (79 downto 72);--DBUS_5;
          when "010000" => rmux <= "10" & x"2C";    
          when "010001" => rmux <= "00" & l_data_d (71 downto 64);--DBUS_6;
          when "010010" => rmux <= "01" & l_data_d (71 downto 64);--DBUS_6;
          when "010011" => rmux <= "10" & x"2C";    
          when "010100" => rmux <= "00" & l_data_d (63 downto 56);--DBUS_7;
          when "010101" => rmux <= "01" & l_data_d (63 downto 56);--DBUS_7;
          when "010110" => rmux <= "10" & x"2C";    
          when "010111" => rmux <= "00" & l_data_d (55 downto 48);--DBUS_8;
          when "011000" => rmux <= "01" & l_data_d (55 downto 48);--DBUS_8;
          when "011001" => rmux <= "10" & x"2C";    
          when "011010" => rmux <= "00" & l_data_d (47 downto 40);--DBUS_9; 
          when "011011" => rmux <= "01" & l_data_d (47 downto 40);--DBUS_9;
          when "011100" => rmux <= "10" & x"2C";
          when "011101" => rmux <= "00" & l_data_d (39 downto 32);--DBUS_10; 
          when "011110" => rmux <= "01" & l_data_d (39 downto 32);--DBUS_10; 
          when "011111" => rmux <= "10" & x"20";
          when "100000" => rmux <= "10" & x"20";
          when "100001" => rmux <= "00" & l_data_d (31 downto 24 ); --TICK
          when "100010" => rmux <= "01" & l_data_d (31 downto 24 ); --TICK
          when "100011" => rmux <= "00" & l_data_d (23 downto 16 ); --TICK
          when "100100" => rmux <= "01" & l_data_d (23 downto 16 ); --TICK
          when "100101" => rmux <= "00" & l_data_d (15  downto 8 ); --TICK
          when "100110" => rmux <= "01" & l_data_d (15  downto 8 ); --TICK
          when "100111" => rmux <= "00" & l_data_d (7  downto 0 );  --TICK
          when "101000" => rmux <= "01" & l_data_d (7  downto 0 );  --TICK
          when "101001" => rmux <= "10" & x"0A";
          when "101010" => rmux <= "10" & x"0D";
          when "101011" => rmux <= "10" & x"20"; --this is a bit nasty and ADDR needs to match the ending point
          when others   => rmux <= "10" & x"20";
        end case;
      end if;
    end process read_logic;	

    process (sysclk,rst_b) begin
      if (rst_b = '0') then
        rmux_nibb <= (others => '0');
      elsif (sysclk'event and sysclk = '1') then
        if rmux (9 downto 8) = "00" then
          rmux_nibb <= rmux (7 downto 4);
        else 
          rmux_nibb <= rmux (3 downto 0);
        end if;
      end if;	
    end process;
    
    process (sysclk,rst_b) begin
      if (rst_b = '0') then
        rmux_hex <= (others => '0');
      elsif (sysclk'event and sysclk = '1') then
        if rmux_nibb < "1010" then
          rmux_hex <= x"30" + rmux_nibb; 
        else 
          rmux_hex <=x"41" + (rmux_nibb - x"0a");
        end if;
      end if;	
    end process;		
      
    process (sysclk,rst_b) begin
      if (rst_b = '0') then
        rmux_out <= (others => '0');
      elsif (sysclk'event and sysclk = '1') then
        if rmux(9 downto 8) = "10" then
          rmux_out <= rmux(7 downto 0);
        else 
          rmux_out <= rmux_hex;
        end if;
      end if;		
    end process;
    
    timer_tick: process (sysclk, rst_b)
      begin
        if (rst_b = '0') then
          TICK_counter <= (others => '0');
          TICK <= (others => '0');
        elsif (sysclk'event and sysclk = '1') then
          TICK_counter <= TICK_counter + 1;
          if (TICK_counter = tick_divider ) then
            TICK <= TICK + 1;
            TICK_counter <= (others => '0');
          end if;	
        end if;
      end process;	

    address_counter: process (sysclk, rst_b,Add_inc)
      begin
        if (rst_b = '0' or Add_inc = '0') then
          ADDR <= "000000"; 
          RangeDone <='0';
        elsif (sysclk'event and sysclk = '1') then
          if (loadTSR = '1' and ADDR /= "101100" ) then
            ADDR <= ADDR + 1;
          elsif ADDR = "101100" then
              RangeDone <='1';
              ADDR <= (others => '0');
          end if;	
        end if;
      end process;
      

    Bclk_rising <= Bclk and (not Bclk_dlayed); 
    Xmit_Control: process(state, TDRE_i, Bct, Bclk_rising)
      begin
        inc <= '0'; clr <= '0'; loadTSR <= '0'; shftTSR <= '0'; start <= '0';
      case state is
        when IDLE => 
          if (TDRE_i = '0' ) then
            loadTSR <= '1'; nextstate <= SYNCH;
            else nextstate <= IDLE; 
          end if;
        when SYNCH => 
          if (Bclk_rising = '1') then
            start <= '1'; nextstate <= TDATA;
            else nextstate <= SYNCH; 
          end if;
        when TDATA =>
          if (Bclk_rising = '0') then nextstate <= TDATA;
            elsif (Bct /= 9) then
            shftTSR <= '1'; inc <= '1'; nextstate <= TDATA;
            else clr <= '1'; nextstate <= IDLE; 
          end if;
      end case;
    end process;

    Xmit_update: process (sysclk, rst_b,Add_inc,DBUS)
      begin
      if (rst_b = '0' or Add_inc ='0') then
        TSR <= "111111111"; state <= IDLE; Bct <= 0; Bclk_dlayed <= '0';-- TDR <= DBUS ;
      elsif (sysclk'event and sysclk = '1') then
        state <= nextstate;
        if (clr = '1') then Bct <= 0; elsif (inc = '1') then
          Bct <= Bct + 1; end if;
        if (loadTSR = '1') then TSR <= TDR & '1'; end if;
        if (start = '1') then TSR(0) <= '0'; end if;
        if (shftTSR = '1') then TSR <= '1' & TSR(8 downto 1); end if; -- shift out one bit
          Bclk_dlayed <= Bclk; 
      end if;
    end process;

    process (sysclk,rst_b) begin
      if (rst_b = '0') then
        TDRE_i <='1';
        Add_inc <='0';
        fifo_rd_en <= '0';
      elsif (sysclk'event and sysclk = '1') then
        fifo_rd_en <= '0';
        if (fifo_empty /= '1' and Add_inc ='0' ) then
          fifo_rd_en <= '1';
          Add_inc <= '1';
          TDRE_i <= '0';
        elsif RangeDone = '1' then	
          TDRE_i <= '1';
          Add_inc <= '0';
        end if;
      end if;	
    end process;


    process (sysclk,rst_b) begin
    if (rst_b = '0') then
      l_data_t <= (others => '0');
      fifo_reset <='1';
      fifo_wr_en <= '0';
    elsif (sysclk'event and sysclk = '1') then
      fifo_reset <= '0';
      fifo_wr_en <= '0';
      if l_data_t /= l_data and fifo_full /= '1' then
        l_data_t <=  l_data;
        l_data_fifo <= l_data & TICK;
        fifo_wr_en <= '1';
      end if;
    end if;	
    end process;

    uut1 : fifo_top port map  
    (
        Data 			=>	l_data_fifo,
        WrClk 		=>	sysclk,
        RdClk 		=>	sysclk,
        WrEn 			=>	fifo_wr_en,
        RdEn 			=>	fifo_rd_en,
        Q 				=>  l_data_d,	
        Empty 		=>	fifo_empty,
        Full 		 	=>	fifo_full
    );

  end xmit;
    
	
	
	