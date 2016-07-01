library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compara_coordenadas is
port
(
	--inputs
	Xin1			: in std_logic_vector(10 downto 0);
	Yin1			: in std_logic_vector(10 downto 0);
	Xin2			: in std_logic_vector(10 downto 0);
	Yin2			: in std_logic_vector(10 downto 0);
	
	--outputs
	Comparacion		: out std_logic
);
end Compara_coordenadas;

architecture beh of Compara_coordenadas is

begin

Comparacion <= '1' when (Xin1 = Xin2 and Yin1 = Yin2) else '0';

end beh;