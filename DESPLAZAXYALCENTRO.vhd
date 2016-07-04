library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DesplazaXYalCentro is

	port(
		Clk		:	in	std_logic;
		Xin		:	in unsigned(9 downto 0);
		Yin		:	in unsigned(9 downto 0);
		Xout		:	out signed(9 downto 0);
		Yout		:	out signed(9 downto 0)
	);
end DesplazaXYalCentro;

architecture beh of DesplazaXYalCentro is
begin
	Desplazar: process(Clk,Xin,Yin)
	begin
		Xout <= signed(std_logic_vector(Xin)) - to_signed(320,10);
		Yout <= signed(std_logic_vector(Yin)) - to_signed(240,10);
	end process;
end beh;