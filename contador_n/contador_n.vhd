-- Arthur Coronho, Lucas Szuster, Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity contador_n is
  generic (
    -- quantidade de contagem
    N : integer := 4
  );
  port (
    -- entradas
    clear_contador : in std_logic;
    clk : in std_logic;
    
    -- saídas
    count : out std_logic := '0'
  );
end entity;

architecture cnt of contador_n is
	-- declaração de um signal para realizar as contas
	signal contador : integer range 0 to N := 0;
begin
	process(clk, clear_contador)
    begin
		if (clear_contador = '1') then
			-- clear_contador ligado, a saída vai para 0
            count <= '0';
            
            -- a contagem deve ser reiniciada
            contador <= 0;
		elsif (rising_edge(clk)) then            
            if (contador = N) then
                -- indicar o fim do ciclo do contador na saída count
            	count <= '1';
                
                -- como foi atingido o limite de contagem, contador é zerado
                contador <= 0;
            else
            	-- o contador não é igual a N, deve ser incrementado
				contador <= contador + 1;
                
                -- a saída count deve ser 0
            	count <= '0';
            end if;
      end if;
  end process;
end architecture;
