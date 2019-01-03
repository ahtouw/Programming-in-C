--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------


Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;



--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
	component fulladder
		port (a : in std_logic;
          	b : in std_logic;
         	 cin : in std_logic;
          	sum : out std_logic;
          	carry : out std_logic
        	 );
	end component;
	signal c: std_logic_vector (0 to 30); --signal vector to save carry out to
	signal b: std_logic_vector (31 downto 0); -- signal vector to store datain_b if add_sub is 1 meaning it needs to subtract 
begin
	invert: for m in 31 downto 0 generate
		b(m) <= datain_b(m) xor add_sub;
	end generate invert;
		a0: fulladder port map(datain_a(0), b(0), add_sub, dataout(0), c(0));
		stage: for I in 1 to 30 generate
			as: fulladder port map(datain_a(I), b(I), c(I-1), dataout(I), c(I));
		end generate stage;
		a31: fulladder port map(datain_a(31), b(31), c(30), dataout(31), co);  
end architecture calc;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	
begin
	process(dir, shamt) is

	begin
	if (dir ='1') then
		case shamt is
		when "00001" =>
			dataout<= ("0"&datain(31 downto 1));
		when "00010" =>
			dataout<= ("00"&datain(31 downto 2));
		when "00011" =>
			dataout<= ("000"&datain(31 downto 3));
		when others =>
			dataout<= datain(31 downto 0);
		end case;

	else
		case shamt is
		when "00001" =>
			dataout<= (datain(30 downto 0)&"0");
		when "00010" =>
			dataout<= (datain(29 downto 0)&"00");
		when "00011" =>
			dataout<= (datain(28 downto 0)&"000");
		when others =>
			dataout<= datain(31 downto 0);
		end case;

	end if;
	end process;
end architecture shifter;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		Control: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;

	signal c: std_logic; --signalto save carry out to
	signal b: std_logic_vector (31 downto 0); -- signal vector to store outputs

begin
	process(Control) is
	begin
	case Control is
		when "00000" =>
			A1: adder_subtracter port map(DataIn1, DataIn2, '0', b, c); -- add
		when "00100" =>
			S1: adder_subtracter port map(DataIn1, DataIn2, '1', b, c); -- sub
		when "10000" =>
			A2: adder_subtracter port map(DataIn1, ("0000000000000000"&DataIn2(15 downto 0)), '0', b, c); -- addi
		when "01000" =>
			b <= DataIn1 and DataIn2; -- and
		when "00010" =>
			b <= DataIn1 or DataIn2; -- or
		when "10010" =>
			b <= DataIn1 or ("0000000000000000"&DataIn2(15 downto 0)); -- ori
		when "00001" =>
			SL: shift_register port map(DataIn1, '0', DataIn2(10 downto 6), b);
		when "00101" =>
			SR: shift_register port map(DataIn1, '1', DataIn2(10 downto 6), b);
		when others =>
			null;
	end case;

	if (b = "00000000000000000000000000000000") then
		Zero <= '1';
	else
		Zero <= '0';
	end if;

	ALUResult <= b;
	end process;
end architecture ALU_Arch;


