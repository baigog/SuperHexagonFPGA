library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador is

	port(
	Clk	:	in	std_logic;
	Rst	:	in std_logic;
	EN		:	in std_logic;
	
	cuenta : out std_logic_vector(3 downto 0);
	ovf	:	out std_logic
	);
end Contador;

architecture beh of Contador is

begin
	Cont: process (Clk, Rst)
		variable aux : unsigned(3 downto 0) := (others => '0');	--Salida auxiliar
	begin
		if(Rst='1') then
			aux:=(others=>'0');
			ovf<='0';
		elsif (EN='1') then
			if(rising_edge(Clk)) then
				aux:=aux+1;
				if (aux="1010") then
					ovf<='1';
					aux:="0000";
				else
					ovf<='0';
				end if;
			end if;
		end if;	
	cuenta <= std_logic_vector(aux);
	end process;
end beh;