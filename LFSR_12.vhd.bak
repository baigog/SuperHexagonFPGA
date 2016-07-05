library ieee; 
use ieee.std_logic_1164.all;
use work.Lab6_Pack.all;

--CONTADOR LINEAR FEEDBACK SHIFT REGISTER.
--Cuenta una secuencia pseudoaleatoria de 4 bits cíclica de 15 estados.  Posee una entrada de seteo.

entity LFSR_12 is
	port
	(
		-- Input ports
		Clk	: in  std_logic;		--Entrada de reloj
		Set	: in	std_logic;		--Entrada de seteo
		En		: in	std_logic;

		-- Output ports
		b	: out std_logic_vector(addr_width-1 downto 0)
	);
end LFSR_12;

architecture shift of LFSR_12 is
	
	component FF_D_RISING is
		port
		(
			-- Input ports
			D		: in  std_logic;
			Clk	: in  std_logic;		--Reloj
			Set	: in	std_logic;		--Seteo asincrónico
			Reset	: in	std_logic;
			En		: in	std_logic;

			-- Output ports
			Q	: out std_logic
		);
	end component;

	signal XOR1: std_logic;								--Salida de XOR
	signal int: std_logic_vector(addr_width-1 downto 0);		--Conexiones internas del contador, sirven como salidas también.
	
begin

	XOR1<=int(11) XOR int(5) xor int(3) XOR int(0);		
	
	LFSR: for i in 11 downto 0 generate
		i32: if (i<addr_width and i>0) generate
			bit32: FF_D_RISING port map(D=>int(i-1), Clk=>Clk, Set=>Set,Q=>int(i),reset=>'0',En=>En);	--demas bits de salida
		end generate i32;
		i0: if(i=0) generate
			bit0: FF_D_RISING port map(D=>XOR1,Clk=>Clk,Set=>Set,Q=>int(i),reset=>'0',En=>En);			--Primer bit
		end generate i0;
	end generate LFSR;
	
	b<=int;
	
end shift;
	