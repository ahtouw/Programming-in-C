--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type := (others => (others => '0'));


begin

  RamProc: process(Clock, Reset, OE, WE) is

  begin
    if Reset = '1' then
	-- Code to reset the RAM
	DataOut <= (others => '0');
	for i in i_ram'range loop
		i_ram(i) <= (others => '0');
	end loop;
    end if;

    if falling_edge(Clock) then
	-- Add code to write data to RAM
	if (WE='1') then
		if (to_integer(unsigned(Address)) < 128) then --checks if address is in allowable range
			i_ram(to_integer(unsigned(Address))) <= DataIn;
		else
			DataOut <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; --if out of range, returns 'Z'
		end if;
	end if;
    end if;

	-- Rest of the RAM implementation
    if rising_edge(Clock) then
		if (OE = '0') then
			if (to_integer(unsigned(Address)) < 128) then
				DataOut <= i_ram(to_integer(unsigned(Address)));
			else
				DataOut <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
			end if;
		end if;
    end if;
  end process RamProc;
end staticRAM;		


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;

	--register bank
    signal at: std_logic_vector(31 downto 0);
    signal v0: std_logic_vector(31 downto 0);
    signal v1: std_logic_vector(31 downto 0);
    signal a0: std_logic_vector(31 downto 0);
    signal a1: std_logic_vector(31 downto 0);
    signal a2: std_logic_vector(31 downto 0);
    signal a3: std_logic_vector(31 downto 0);
    signal t0: std_logic_vector(31 downto 0);
    signal t1: std_logic_vector(31 downto 0);
    signal t2: std_logic_vector(31 downto 0);
    signal t3: std_logic_vector(31 downto 0);
    signal t4: std_logic_vector(31 downto 0);
    signal t5: std_logic_vector(31 downto 0);
    signal t6: std_logic_vector(31 downto 0);
    signal t7: std_logic_vector(31 downto 0);
	signal s0: std_logic_vector(31 downto 0);
	signal s1: std_logic_vector(31 downto 0);
	signal s2: std_logic_vector(31 downto 0);
	signal s3: std_logic_vector(31 downto 0);
	signal s4: std_logic_vector(31 downto 0);
	signal s5: std_logic_vector(31 downto 0);
	signal s6: std_logic_vector(31 downto 0);
	signal s7: std_logic_vector(31 downto 0);
    signal t8: std_logic_vector(31 downto 0);
    signal t9: std_logic_vector(31 downto 0);
    signal k0: std_logic_vector(31 downto 0);
    signal k1: std_logic_vector(31 downto 0);
    signal gp: std_logic_vector(31 downto 0);
    signal sp: std_logic_vector(31 downto 0);
    signal fp: std_logic_vector(31 downto 0);
    signal ra: std_logic_vector(31 downto 0);
	signal zero: std_logic_vector(31 downto 0);
begin
    -- Code  for the Register Bank implementation
	process (WriteReg, WriteCmd, WriteData) is
	begin
		-- if Write Command is enabled, WriteData is written to which ever register specified.
		if (WriteCmd ='1') then
			case WriteReg is
                when "00000" =>
                    zero <= "00000000000000000000000000000000";
                when "00001" =>
                    at <= WriteData;
                when "00010" =>
                    v0 <= WriteData;
                when "00011" =>
                    v1 <= WriteData;
                when "00100" =>
                    a0 <=WriteData;
                when "00101" =>
                    a1 <= WriteData;
                when "00110" =>
                    a2 <= WriteData;
                when "00111" =>
                    a3 <= WriteData;
                when "01000" =>
                    t0 <= WriteData;
                when "01001" =>
                    t1 <= WriteData;
                when "01010" =>
                    t2 <= WriteData;
                when "01011" =>
                    t3 <= WriteData;
                when "01100" =>
                    t4 <= WriteData;
                when "01101" =>
                    t5 <= WriteData;
                when "01110" =>
                    t6 <= WriteData;
                when "01111" =>
                    t7 <= WriteData;
                when "10000" =>
		    s0 <= WriteData;
		when "10001" =>
		    s1 <= WriteData;
		when "10010" =>
		    s2 <= WriteData;
		when "10011" =>
		    s3 <= WriteData;
		when "10100" =>
		    s4 <= WriteData;
		when "10101" =>
		    s5 <= WriteData;
		when "10110" =>
		    s6 <= WriteData;
		when "10111" =>
		    s7 <= WriteData;
                when "11000" =>
                    t8 <= WriteData;
                when "11001" =>
                    t9 <= WriteData;
                when "11010" =>
                    k0 <= WriteData;
                when "11011" =>
                    k1 <= WriteData;
                when "11100" =>
                    gp <= WriteData;
                when "11101" =>
                    sp <= WriteData;
                when "11110" =>
                    fp <= WriteData;
		when others =>
		    ra <= WriteData;
			end case;
		end if;
	end process;
	
	--output gets the data stored in whichever register that is specified
	with ReadReg1 select
	ReadData1 <= "00000000000000000000000000000000" when "00000",
        at when "00001",
        v0 when "00010",
        v1 when "00011",
        a0 when "00100",
        a1 when "00101",
        a2 when "00110",
        a3 when "00111",
        t0 when "01000",
        t1 when "01001",
        t2 when "01010",
        t3 when "01011",
        t4 when "01100",
        t5 when "01101",
        t6 when "01110",
        t7 when "01111",
        s0 when "10000",
	s1 when "10001",
	s2 when "10010",
	s3 when "10011",
	s4 when "10100",
	s5 when "10101",
	s6 when "10110",
	s7 when "10111",
        t8 when "11000",
        t9 when "11001",
        k0 when "11010",
        k1 when "11011",
        gp when "11100",
        sp when "11101",
        fp when "11110",
	ra when others;

    with ReadReg2 select
    ReadData2 <= "00000000000000000000000000000000" when "00000",
        at when "00001",
        v0 when "00010",
        v1 when "00011",
        a0 when "00100",
        a1 when "00101",
        a2 when "00110",
        a3 when "00111",
        t0 when "01000",
        t1 when "01001",
        t2 when "01010",
        t3 when "01011",
        t4 when "01100",
        t5 when "01101",
        t6 when "01110",
        t7 when "01111",
        s0 when "10000",
        s1 when "10001",
        s2 when "10010",
        s3 when "10011",
        s4 when "10100",
        s5 when "10101",
        s6 when "10110",
        s7 when "10111",
        t8 when "11000",
        t9 when "11001",
        k0 when "11010",
        k1 when "11011",
        gp when "11100",
        sp when "11101",
        fp when "11110",
        ra when others;

end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
			enout: in std_logic;
			writein: in std_logic;
			dataout: out std_logic_vector(7 downto 0));
	end component;
	signal e32, e16, e8: std_logic; --signal for enout
	signal w32, w16, w8: std_logic; --signal for writein
begin
	--enable 32 bits when enout32 is low
	e32 <= enout32;
	--enable 16  bits when enout 32 or enout16 is low
	e16 <= (enout32 and enout16);
	--enable 8 bits when enout32, enout16, or enout 8 are low
	e8 <= (enout32 and enout16 and enout8);
	--write 32 bits when writein32 is high
	w32 <= writein32;
	--write 16 bits when writein32 or writein16 are high
	w16 <= (writein32 or writein16);
	--write 8 bits when writein32, writein16, or writein8 are high
	w8 <= (writein32 or writein16 or writein8);
	--generates dataout using the register8 component and the e and w signals
	Part1: register8 port map(datain(7 downto 0), e8, w8, dataout(7 downto 0));
	Part2: register8 port map(datain(15 downto 8), e16, w16, dataout(15 downto 8));
	Part3: register8 port map(datain(23 downto 16), e32, w32, dataout(23 downto 16));
	Part4: register8 port map(datain(31 downto 24), e32, w32, dataout(31 downto 24));
end architecture biggermem;
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	generic (n: integer := 7);
	port(datain: in std_logic_vector(n downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(n downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	-- insert your code here.
	-- this portion generates all the output bits that will be saved to dataout using the bitstorage component
	part0: bitstorage port map(datain(0), enout, writein, dataout(0));
	part1: bitstorage port map(datain(1), enout, writein, dataout(1));
	part2: bitstorage port map(datain(2), enout, writein, dataout(2));
	part3: bitstorage port map(datain(3), enout, writein, dataout(3));
	part4: bitstorage port map(datain(4), enout, writein, dataout(4));
	part5: bitstorage port map(datain(5), enout, writein, dataout(5));
	part6: bitstorage port map(datain(6), enout, writein, dataout(6));
	part7: bitstorage port map(datain(7), enout, writein, dataout(7));
end architecture memmy;
-------------------------------------------------------------------------------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
