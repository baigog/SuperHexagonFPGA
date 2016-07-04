library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generador_aleatorio is
	port(
		Clk	:	in	std_logic;
		Muestra	:	in	std_logic;
		
		secuencia	:	out	std_logic_vector(63 downto 0)
	);
end generador_aleatorio;

architecture beh of generador_aleatorio is
begin



reg [63:0]data;
assign out = data[BITS-1:0];
wire zero = data == 64'b0;

initial begin
	data = 64'd1;
end

always @(posedge clk) begin
	data <= {data[62:0], (data[63]^data[62]^data[60]^data[59]^sample) || zero};
end

endmodule
