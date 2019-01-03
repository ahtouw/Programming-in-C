--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			Control: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--InputsD:/Documents/ECEGR/2220/lab 4/tALU.vhd
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		Control => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00000";		-- Control in binary (ADD and ADDI test)
		wait for 20 ns; 		-- result = 0x124578AB  and zeroOut = 0

		-- Add test cases here to drive the ALU implementation
		control  <= "00100";		-- Control in binary (SUB test)
		wait for 20 ns; 		-- result = 0xf0011223  and zeroOut = 0

		datain_b <= X"000010E1";
		control  <= "10000";		-- Control in binary (ADDI test)
		wait for 20 ns; 		-- result = 0x1235648  and zeroOut = 0
		
		datain_b <= X"11223344";
		control  <= "01000";		-- Control in binary (AND test)
		wait for 20 ns; 		-- result = 0x1220144  and zeroOut = 0

		control  <= "00010";		-- Control in binary (OR test)
		wait for 20 ns; 		-- result = 0x11237767  and zeroOut = 0

		control  <= "10010";		-- Control in binary (ORI test)
		wait for 20 ns; 		-- result = 0x1237767  and zeroOut = 0

		datain_b <= X"00000080";
		control  <= "00001";		-- Control in binary (SLL test)
		wait for 20 ns; 		-- result = 0x48D159C  and zeroOut = 0

		datain_a <= X"11223344";
		control  <= "00101";		-- Control in binary (SRL test)
		wait for 20 ns; 		-- result = 0x4488CD1  and zeroOut = 0




		wait; -- will wait forever
	END PROCESS;

END;