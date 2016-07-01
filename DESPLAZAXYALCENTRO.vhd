library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DesplazaXYalCentro is

	port(
		Clk		:	in	std_logic;
		Xin		:	in std_logic_vector(9 downto 0);
		Yin		:	in std_logic_vector(9 downto 0);
		Xout		:	out std_logic_vector(9 downto 0);
		Yout		:	out std_logic_vector(9 downto 0)
	);
end DesplazaXYalCentro;

architecture beh of DesplazaXYalCentro is
begin
	Desplazar: process(Clk)
	begin
		Xout <= std_logic_vector(unsigned(Xin) - to_unsigned(320,10));
		Yout <= std_logic_vector(unsigned(Yin) - to_unsigned(240,10));
	end process;
end beh;