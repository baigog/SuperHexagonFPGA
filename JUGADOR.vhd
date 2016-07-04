library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jugador is
	port(
		Clk				: in	std_logic;
		Actualizar		: in	std_logic;
		Vuelve_jugador	: in	std_logic;
		Dificultad		: in	std_logic_vector(1 downto 0);
		Boton_der		: in	std_logic;
		Boton_izq		: in	std_logic;
		
		X_actual			: out	signed(9 downto 0);
		Y_actual			: out	signed(9 downto 0);
		X_anterior		: out	signed(9 downto 0);
		Y_anterior		: out	signed(9 downto 0)
	);
end jugador;

architecture beh of jugador is

component senocoseno is
	port(
	clk		:	in	std_logic;
	angulo	:	in	unsigned(9 downto 0);
	seno		:	out	signed(11 downto 0);
	coseno	:	out	signed(11 downto 0)
	);
end component;

signal angulo	:	unsigned(9 downto 0);
signal seno		:	signed(11 downto 0);
signal coseno	:	signed(11 downto 0);

signal velocidad	:	unsigned(9 downto 0);
signal angulo_anterior	:	unsigned(9 downto 0);

signal x_actual_aux, y_actual_aux	:	signed(9 downto 0);

begin

SC:senocoseno port map(clk=>clk,angulo=>angulo,seno=>seno,coseno=>coseno);

Velocidad_jugador: process (Dificultad)
begin
	case dificultad is
		when "00" =>
			velocidad <= to_unsigned(8,10);
		when "01" =>
			velocidad <= to_unsigned(12,10);
		when "10" =>
			velocidad <= to_unsigned(16,10);
		when "11" =>
			velocidad <= to_unsigned(20,10);
		when others =>
			velocidad <= to_unsigned(8,10);
	end case;
end process;

Actualizar_posicion: process (clk,boton_der,boton_izq,vuelve_jugador,actualizar)
begin
	if (actualizar='1') then
		X_anterior <= X_actual_aux;
		Y_anterior <= Y_actual_aux;
		angulo_anterior <= angulo;
		if(boton_der='1') then
			angulo <= angulo + velocidad;
		elsif(boton_izq='1') then
			angulo <= angulo - velocidad;
		elsif(vuelve_jugador='1') then
			angulo <= angulo_anterior;
		end if;
	end if;
end process;

Posicion_jugador: process(clk)
begin
	x_actual_aux <=	signed((11 DOWNTO 8 => coseno(11))&coseno(11 downto 6)) + signed((11 DOWNTO 7 => coseno(11))&coseno(11 downto 7));
	x_actual_aux <=	signed((11 DOWNTO 8 => seno(11))&seno(11 downto 6)) + signed((11 DOWNTO 7 => seno(11))&seno(11 downto 7));	
end process;

x_actual <= x_actual_aux;
y_actual <= y_actual_aux;
end beh;
