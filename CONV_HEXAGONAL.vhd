library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_hexagonal is
	port(
		clk		: in std_logic;
		x			: in signed (9 downto 0);
		y			: in signed (9 downto 0);
		
		cuadrante	: out unsigned (2 downto 0);
		radio			: out unsigned (9 downto 0)
		);
end conv_hexagonal;

architecture beh of conv_hexagonal is

constant raiz_de_3 : signed (11 downto 0) := "011011101101";

signal raiz_de_3_x, raiz_de_3_x_neg		: signed (10 downto 0);
signal raiz_de_3_x_completo				: signed (22 downto 0);
signal y_extendido, y_negado				: signed (10 downto 0);

signal radio_frac		: signed (11 downto 0);

begin

raiz_de_3_x_completo <= signed(x(9)&x)*raiz_de_3;
raiz_de_3_x <= signed(raiz_de_3_x_completo(22 downto 12));
raiz_de_3_x_neg <= to_signed(0,11) - raiz_de_3_x;

y_extendido <= signed(y(9)&y);
y_negado <=  to_signed(0,11) - y_extendido;


convertir : process (clk, y_extendido, raiz_de_3_x)
begin
	if (rising_edge(clk)) then
		if (y_extendido > to_signed(0,11)) then
			if (y_extendido < raiz_de_3_x) then
				cuadrante <= to_unsigned(0,3);
				radio_frac <= y_extendido + raiz_de_3_x;
				radio <= unsigned(radio_frac(11 downto 1));
			elsif (y_extendido < raiz_de_3_x_neg) then
				cuadrante <= to_unsigned(2,3);
				radio_frac <= y_extendido + raiz_de_3_x_neg;
				radio <= unsigned(radio_frac(11 downto 1));
			else
				cuadrante <= to_unsigned(1,3);
				radio <= unsigned(y);
			end if;
		else
			if (y_extendido > raiz_de_3_x) then
				cuadrante <= to_unsigned(3,3);
				radio_frac <= y_negado + raiz_de_3_x;
				radio <= unsigned(radio_frac(11 downto 1));
			elsif (y_extendido > raiz_de_3_x_neg) then
				cuadrante <= to_unsigned(5,3);
				radio_frac <= y_negado + raiz_de_3_x;
				radio <= unsigned(radio_frac(11 downto 1));
			else
				cuadrante <= to_unsigned(4,3);
				radio <= unsigned(y_negado);
			end if;
		end if;
	end if;
end process;

end beh;