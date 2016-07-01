library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Juego_Fsm is
	port(
		Clk				:	in	std_logic;
		Frame_inicio	:	in	std_logic;
		Frame_fin		:	in	std_logic;
		Nuevo_juego		:	in	std_logic;
		Colision_nuevo	:	in	std_logic;
		Colision_viejo	:	in	std_logic;
		Reset				:	in std_logic;
		
		Actualizar		:	out std_logic;
		Rst				:	out std_logic;
		Vuelve_jugador	:	out std_logic;
		Game_over		:	out std_logic	
	);
end Juego_Fsm;

architecture beh of Juego_Fsm is

type FSM_states is (IDLE, RESTART, JUGANDO, NUEVACOLISION, VIEJACOLISION, COLISIONDOBLE);
signal current_state,next_state:FSM_states;

begin
PROXIMO_ESTADO: process(current_state, frame_inicio, frame_fin, clk, colision_nuevo, colision_viejo, nuevo_juego)
begin
	case current_state is
		when IDLE => 
			if (nuevo_juego='1' and frame_inicio='1') then
				next_state <= RESTART;
			else
				next_state <= IDLE;
			end if;
		when RESTART =>
			if (frame_fin='1') then
				next_state <= JUGANDO;
			else
				next_state <= RESTART;
			end if;
		when JUGANDO =>
			if (colision_nuevo='1' and colision_viejo='1') then
				next_state <= COLISIONDOBLE;
			elsif (Colision_nuevo='1') then
				next_state <= NUEVACOLISION;
			elsif (Colision_viejo='1') then
				next_state <= VIEJACOLISION;
			else
				next_state <= JUGANDO;
			end if;
		when NUEVACOLISION =>
			if (colision_viejo='1') then
				next_state <= COLISIONDOBLE;
			elsif (frame_fin='1') then
				next_state <= JUGANDO;
			else
				next_state <= NUEVACOLISION;
			end if;
		when VIEJACOLISION =>
			if (colision_nuevo='1') then 
				next_state <= COLISIONDOBLE;
			elsif (frame_fin='1') then
				next_state <= JUGANDO;
			else
				next_state <= VIEJACOLISION;
			end if;
		when COLISIONDOBLE =>
			if (frame_fin='1') then
				next_state <= IDLE;
			else
				next_state <= COLISIONDOBLE;
			end if;
		when others => 
			next_state <= IDLE;
	end case;
end process;
		
ESTADO_ACTUAL: process(clk,Reset)
begin
	if(Reset='1') then
		current_state<=IDLE;
	elsif(rising_edge(Clk)) then
		current_state<=next_state;
	end if;
end process;		

Salida: process(Reset,Current_state,Clk)
begin		
	if (reset='1') then
		Game_over <= '1';
		Actualizar <= '0';
		rst <= '1';
		Vuelve_jugador <= '0';	
	elsif (rising_edge(clk)) then
		Rst <= '0';
		Game_over <= '0';
		Actualizar <= '0';
		Vuelve_jugador <= '0';
		case Current_state is
			when IDLE =>
				Game_over <= '1';
			when RESTART =>
				Rst <= '1';
			when JUGANDO =>
				if (frame_inicio='1') then
					Actualizar <= '1';
				end if;
			when NUEVACOLISION =>
				if ((colision_viejo='0') and frame_fin='1') then
					Vuelve_jugador <= '1';
				end if;
			when VIEJACOLISION => null;
			when COLISIONDOBLE => null;
		end case;
	end if;
end process;
end beh;
		
