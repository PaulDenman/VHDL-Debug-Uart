-- VHDL netlist generated by SCUBA Diamond Version 3.2.0.134
-- Module  Version: 5.7
--C:\lscc\diamond\3.2\ispfpga\bin\nt\scuba.exe -w -n uart_fifo -lang vhdl -synth synplify -bus_exp 7 -bb -arch xo2c00 -type ebfifo -depth 64 -width 80 -rwidth 80 -no_enable -pe 1 -pf 15 

-- Fri Jan 30 13:01:41 2015

library IEEE;
use IEEE.std_logic_1164.all;
-- synopsys translate_off
library MACHXO2;
use MACHXO2.components.all;
-- synopsys translate_on

entity uart_fifo is
    port (
        Data: in  std_logic_vector(79 downto 0); 
        WrClock: in  std_logic; 
        RdClock: in  std_logic; 
        WrEn: in  std_logic; 
        RdEn: in  std_logic; 
        Reset: in  std_logic; 
        RPReset: in  std_logic; 
        Q: out  std_logic_vector(79 downto 0); 
        Empty: out  std_logic; 
        Full: out  std_logic; 
        AlmostEmpty: out  std_logic; 
        AlmostFull: out  std_logic);
end uart_fifo;

architecture Structure of uart_fifo is

    -- internal signal declarations
    signal scuba_vhi: std_logic;
    signal Empty_int: std_logic;
    signal Full_int: std_logic;
    signal scuba_vlo: std_logic;

    -- local component declarations
    component VHI
        port (Z: out  std_logic);
    end component;
    component VLO
        port (Z: out  std_logic);
    end component;
    component FIFO8KB
        generic (FULLPOINTER1 : in String; FULLPOINTER : in String; 
                AFPOINTER1 : in String; AFPOINTER : in String; 
                AEPOINTER1 : in String; AEPOINTER : in String; 
                ASYNC_RESET_RELEASE : in String; RESETMODE : in String; 
                GSR : in String; CSDECODE_R : in String; 
                CSDECODE_W : in String; REGMODE : in String; 
                DATA_WIDTH_R : in Integer; DATA_WIDTH_W : in Integer);
        port (DI0: in  std_logic; DI1: in  std_logic; DI2: in  std_logic; 
            DI3: in  std_logic; DI4: in  std_logic; DI5: in  std_logic; 
            DI6: in  std_logic; DI7: in  std_logic; DI8: in  std_logic; 
            DI9: in  std_logic; DI10: in  std_logic; DI11: in  std_logic; 
            DI12: in  std_logic; DI13: in  std_logic; 
            DI14: in  std_logic; DI15: in  std_logic; 
            DI16: in  std_logic; DI17: in  std_logic; 
            CSW0: in  std_logic; CSW1: in  std_logic; 
            CSR0: in  std_logic; CSR1: in  std_logic; 
            FULLI: in  std_logic; EMPTYI: in  std_logic; 
            WE: in  std_logic; RE: in  std_logic; ORE: in  std_logic; 
            CLKW: in  std_logic; CLKR: in  std_logic; RST: in  std_logic; 
            RPRST: in  std_logic; DO0: out  std_logic; 
            DO1: out  std_logic; DO2: out  std_logic; 
            DO3: out  std_logic; DO4: out  std_logic; 
            DO5: out  std_logic; DO6: out  std_logic; 
            DO7: out  std_logic; DO8: out  std_logic; 
            DO9: out  std_logic; DO10: out  std_logic; 
            DO11: out  std_logic; DO12: out  std_logic; 
            DO13: out  std_logic; DO14: out  std_logic; 
            DO15: out  std_logic; DO16: out  std_logic; 
            DO17: out  std_logic; EF: out  std_logic; 
            AEF: out  std_logic; AFF: out  std_logic; FF: out  std_logic);
    end component;
    attribute syn_keep : boolean;
    attribute NGD_DRC_MASK : integer;
    attribute NGD_DRC_MASK of Structure : architecture is 1;

begin
    -- component instantiation statements
    uart_fifo_0_4: FIFO8KB
        generic map (FULLPOINTER1=> "0b00001111110000", FULLPOINTER=> "0b00010000000000", 
        AFPOINTER1=> "0b00000011100000", AFPOINTER=> "0b00000011110000", 
        AEPOINTER1=> "0b00000000100000", AEPOINTER=> "0b00000000010000", 
        ASYNC_RESET_RELEASE=> "SYNC", GSR=> "DISABLED", RESETMODE=> "ASYNC", 
        REGMODE=> "NOREG", CSDECODE_R=> "0b11", CSDECODE_W=> "0b11", 
        DATA_WIDTH_R=>  18, DATA_WIDTH_W=>  18)
        port map (DI0=>Data(0), DI1=>Data(1), DI2=>Data(2), DI3=>Data(3), 
            DI4=>Data(4), DI5=>Data(5), DI6=>Data(6), DI7=>Data(7), 
            DI8=>Data(8), DI9=>Data(9), DI10=>Data(10), DI11=>Data(11), 
            DI12=>Data(12), DI13=>Data(13), DI14=>Data(14), 
            DI15=>Data(15), DI16=>Data(16), DI17=>Data(17), 
            CSW0=>scuba_vhi, CSW1=>scuba_vhi, CSR0=>scuba_vhi, 
            CSR1=>scuba_vhi, FULLI=>Full_int, EMPTYI=>Empty_int, 
            WE=>WrEn, RE=>RdEn, ORE=>RdEn, CLKW=>WrClock, CLKR=>RdClock, 
            RST=>Reset, RPRST=>RPReset, DO0=>Q(9), DO1=>Q(10), 
            DO2=>Q(11), DO3=>Q(12), DO4=>Q(13), DO5=>Q(14), DO6=>Q(15), 
            DO7=>Q(16), DO8=>Q(17), DO9=>Q(0), DO10=>Q(1), DO11=>Q(2), 
            DO12=>Q(3), DO13=>Q(4), DO14=>Q(5), DO15=>Q(6), DO16=>Q(7), 
            DO17=>Q(8), EF=>Empty_int, AEF=>AlmostEmpty, AFF=>AlmostFull, 
            FF=>Full_int);

    uart_fifo_1_3: FIFO8KB
        generic map (FULLPOINTER1=> "0b00000000000000", FULLPOINTER=> "0b11111111110000", 
        AFPOINTER1=> "0b00000000000000", AFPOINTER=> "0b11111111110000", 
        AEPOINTER1=> "0b00000000000000", AEPOINTER=> "0b11111111110000", 
        ASYNC_RESET_RELEASE=> "SYNC", GSR=> "DISABLED", RESETMODE=> "ASYNC", 
        REGMODE=> "NOREG", CSDECODE_R=> "0b11", CSDECODE_W=> "0b11", 
        DATA_WIDTH_R=>  18, DATA_WIDTH_W=>  18)
        port map (DI0=>Data(18), DI1=>Data(19), DI2=>Data(20), 
            DI3=>Data(21), DI4=>Data(22), DI5=>Data(23), DI6=>Data(24), 
            DI7=>Data(25), DI8=>Data(26), DI9=>Data(27), DI10=>Data(28), 
            DI11=>Data(29), DI12=>Data(30), DI13=>Data(31), 
            DI14=>Data(32), DI15=>Data(33), DI16=>Data(34), 
            DI17=>Data(35), CSW0=>scuba_vhi, CSW1=>scuba_vhi, 
            CSR0=>scuba_vhi, CSR1=>scuba_vhi, FULLI=>Full_int, 
            EMPTYI=>Empty_int, WE=>WrEn, RE=>RdEn, ORE=>RdEn, 
            CLKW=>WrClock, CLKR=>RdClock, RST=>Reset, RPRST=>RPReset, 
            DO0=>Q(27), DO1=>Q(28), DO2=>Q(29), DO3=>Q(30), DO4=>Q(31), 
            DO5=>Q(32), DO6=>Q(33), DO7=>Q(34), DO8=>Q(35), DO9=>Q(18), 
            DO10=>Q(19), DO11=>Q(20), DO12=>Q(21), DO13=>Q(22), 
            DO14=>Q(23), DO15=>Q(24), DO16=>Q(25), DO17=>Q(26), EF=>open, 
            AEF=>open, AFF=>open, FF=>open);

    uart_fifo_2_2: FIFO8KB
        generic map (FULLPOINTER1=> "0b00000000000000", FULLPOINTER=> "0b11111111110000", 
        AFPOINTER1=> "0b00000000000000", AFPOINTER=> "0b11111111110000", 
        AEPOINTER1=> "0b00000000000000", AEPOINTER=> "0b11111111110000", 
        ASYNC_RESET_RELEASE=> "SYNC", GSR=> "DISABLED", RESETMODE=> "ASYNC", 
        REGMODE=> "NOREG", CSDECODE_R=> "0b11", CSDECODE_W=> "0b11", 
        DATA_WIDTH_R=>  18, DATA_WIDTH_W=>  18)
        port map (DI0=>Data(36), DI1=>Data(37), DI2=>Data(38), 
            DI3=>Data(39), DI4=>Data(40), DI5=>Data(41), DI6=>Data(42), 
            DI7=>Data(43), DI8=>Data(44), DI9=>Data(45), DI10=>Data(46), 
            DI11=>Data(47), DI12=>Data(48), DI13=>Data(49), 
            DI14=>Data(50), DI15=>Data(51), DI16=>Data(52), 
            DI17=>Data(53), CSW0=>scuba_vhi, CSW1=>scuba_vhi, 
            CSR0=>scuba_vhi, CSR1=>scuba_vhi, FULLI=>Full_int, 
            EMPTYI=>Empty_int, WE=>WrEn, RE=>RdEn, ORE=>RdEn, 
            CLKW=>WrClock, CLKR=>RdClock, RST=>Reset, RPRST=>RPReset, 
            DO0=>Q(45), DO1=>Q(46), DO2=>Q(47), DO3=>Q(48), DO4=>Q(49), 
            DO5=>Q(50), DO6=>Q(51), DO7=>Q(52), DO8=>Q(53), DO9=>Q(36), 
            DO10=>Q(37), DO11=>Q(38), DO12=>Q(39), DO13=>Q(40), 
            DO14=>Q(41), DO15=>Q(42), DO16=>Q(43), DO17=>Q(44), EF=>open, 
            AEF=>open, AFF=>open, FF=>open);

    uart_fifo_3_1: FIFO8KB
        generic map (FULLPOINTER1=> "0b00000000000000", FULLPOINTER=> "0b11111111110000", 
        AFPOINTER1=> "0b00000000000000", AFPOINTER=> "0b11111111110000", 
        AEPOINTER1=> "0b00000000000000", AEPOINTER=> "0b11111111110000", 
        ASYNC_RESET_RELEASE=> "SYNC", GSR=> "DISABLED", RESETMODE=> "ASYNC", 
        REGMODE=> "NOREG", CSDECODE_R=> "0b11", CSDECODE_W=> "0b11", 
        DATA_WIDTH_R=>  18, DATA_WIDTH_W=>  18)
        port map (DI0=>Data(54), DI1=>Data(55), DI2=>Data(56), 
            DI3=>Data(57), DI4=>Data(58), DI5=>Data(59), DI6=>Data(60), 
            DI7=>Data(61), DI8=>Data(62), DI9=>Data(63), DI10=>Data(64), 
            DI11=>Data(65), DI12=>Data(66), DI13=>Data(67), 
            DI14=>Data(68), DI15=>Data(69), DI16=>Data(70), 
            DI17=>Data(71), CSW0=>scuba_vhi, CSW1=>scuba_vhi, 
            CSR0=>scuba_vhi, CSR1=>scuba_vhi, FULLI=>Full_int, 
            EMPTYI=>Empty_int, WE=>WrEn, RE=>RdEn, ORE=>RdEn, 
            CLKW=>WrClock, CLKR=>RdClock, RST=>Reset, RPRST=>RPReset, 
            DO0=>Q(63), DO1=>Q(64), DO2=>Q(65), DO3=>Q(66), DO4=>Q(67), 
            DO5=>Q(68), DO6=>Q(69), DO7=>Q(70), DO8=>Q(71), DO9=>Q(54), 
            DO10=>Q(55), DO11=>Q(56), DO12=>Q(57), DO13=>Q(58), 
            DO14=>Q(59), DO15=>Q(60), DO16=>Q(61), DO17=>Q(62), EF=>open, 
            AEF=>open, AFF=>open, FF=>open);

    scuba_vhi_inst: VHI
        port map (Z=>scuba_vhi);

    scuba_vlo_inst: VLO
        port map (Z=>scuba_vlo);

    uart_fifo_4_0: FIFO8KB
        generic map (FULLPOINTER1=> "0b00000000000000", FULLPOINTER=> "0b11111111110000", 
        AFPOINTER1=> "0b00000000000000", AFPOINTER=> "0b11111111110000", 
        AEPOINTER1=> "0b00000000000000", AEPOINTER=> "0b11111111110000", 
        ASYNC_RESET_RELEASE=> "SYNC", GSR=> "DISABLED", RESETMODE=> "ASYNC", 
        REGMODE=> "NOREG", CSDECODE_R=> "0b11", CSDECODE_W=> "0b11", 
        DATA_WIDTH_R=>  18, DATA_WIDTH_W=>  18)
        port map (DI0=>Data(72), DI1=>Data(73), DI2=>Data(74), 
            DI3=>Data(75), DI4=>Data(76), DI5=>Data(77), DI6=>Data(78), 
            DI7=>Data(79), DI8=>scuba_vlo, DI9=>scuba_vlo, 
            DI10=>scuba_vlo, DI11=>scuba_vlo, DI12=>scuba_vlo, 
            DI13=>scuba_vlo, DI14=>scuba_vlo, DI15=>scuba_vlo, 
            DI16=>scuba_vlo, DI17=>scuba_vlo, CSW0=>scuba_vhi, 
            CSW1=>scuba_vhi, CSR0=>scuba_vhi, CSR1=>scuba_vhi, 
            FULLI=>Full_int, EMPTYI=>Empty_int, WE=>WrEn, RE=>RdEn, 
            ORE=>RdEn, CLKW=>WrClock, CLKR=>RdClock, RST=>Reset, 
            RPRST=>RPReset, DO0=>open, DO1=>open, DO2=>open, DO3=>open, 
            DO4=>open, DO5=>open, DO6=>open, DO7=>open, DO8=>open, 
            DO9=>Q(72), DO10=>Q(73), DO11=>Q(74), DO12=>Q(75), 
            DO13=>Q(76), DO14=>Q(77), DO15=>Q(78), DO16=>Q(79), 
            DO17=>open, EF=>open, AEF=>open, AFF=>open, FF=>open);

    Empty <= Empty_int;
    Full <= Full_int;
end Structure;

-- synopsys translate_off
library MACHXO2;
configuration Structure_CON of uart_fifo is
    for Structure
        for all:VHI use entity MACHXO2.VHI(V); end for;
        for all:VLO use entity MACHXO2.VLO(V); end for;
        for all:FIFO8KB use entity MACHXO2.FIFO8KB(V); end for;
    end for;
end Structure_CON;

-- synopsys translate_on
