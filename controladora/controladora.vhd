-- Arthur Coronho Seabra Eiras, Lucas Araújo Campos Szuster, Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity controladora is
    port (
        -- Entradas
        pedestre             : in std_logic;
        outro_pedestre       : in std_logic;
        emergencia           : in std_logic;
        outra_emergencia     : in std_logic;
        ativar_night         : in std_logic;
        clk                  : in std_logic;
        reset                : in std_logic;
        count                : in std_logic;
        
        -- Saídas
        sinal_verde          : out std_logic;
        sinal_amarelo        : out std_logic;
        sinal_vermelho       : out std_logic;
        night                : out std_logic;
        clear_contador       : out std_logic;
        vetor_estado         : out std_logic_vector (2 downto 0);
        vetor_proximo_estado : out std_logic_vector (2 downto 0)
    );
end entity;

architecture con of controladora is
    -- Definir os estados da FSM
    type estado is (
        ESTADO_SINAL_VERMELHO,
        ESTADO_SINAL_AMARELO,
	    ESTADO_SINAL_VERDE,
        ESTADO_RESETAR_SINAL_VERDE,
        ESTADO_RESETAR_SINAL_VERMELHO,
        ESTADO_NIGHT
    );

    -- Definir signals intermediários de estado
    signal estado_atual : estado := ESTADO_SINAL_VERMELHO;
    signal proximo_estado : estado := ESTADO_SINAL_VERMELHO;

begin   
    -- Atualizar estado
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= ESTADO_SINAL_VERMELHO;
        elsif rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -- Definir as saídas com base no estado atual e calcular próximo estado
	process(clk, reset)
   	begin
		case estado_atual is
			when ESTADO_SINAL_VERMELHO =>
				sinal_verde    <= '0';
				sinal_amarelo  <= '0';
				sinal_vermelho <= '1';
				night          <= '0';
				clear_contador <= '0';
				vetor_estado <= "010";
					 
				-- cálculo do próximo estado
				if ((count = '1') or (emergencia = '1')) then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERDE;
				elsif (outra_emergencia = '1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
				elsif (ativar_night ='1') then
					proximo_estado <= ESTADO_NIGHT;
				else 
					proximo_estado <= estado_atual;
				end if;
                
			when ESTADO_SINAL_AMARELO =>
				sinal_verde    <= '0';
				sinal_amarelo  <= '1';
				sinal_vermelho <= '0';
				night          <= '0';
				clear_contador <= '0';
				vetor_estado <= "001";

				-- cálculo do próximo estado
				if (ativar_night ='1') then
					proximo_estado <= ESTADO_NIGHT;
				elsif (emergencia = '1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERDE;
				elsif ((outra_emergencia = '1') or (pedestre = '1')) then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
				else
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
				end if;

			when ESTADO_SINAL_VERDE =>
				sinal_verde    <= '1';
				sinal_amarelo  <= '0';
				sinal_vermelho <= '0';
				night          <= '0';
				clear_contador <= '0';
				vetor_estado <= "000";
	
				-- cálculo do próximo estado
				if (count = '1') then
					proximo_estado <= ESTADO_SINAL_AMARELO;
				elsif (emergencia ='1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERDE;
				elsif ((outra_emergencia = '1') or (pedestre = '1')) then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
				elsif (ativar_night ='1') then
					proximo_estado <= ESTADO_NIGHT;
				else
					proximo_estado <= estado_atual;
				end if;

			when ESTADO_RESETAR_SINAL_VERDE =>
				sinal_verde    <= '1';
				sinal_amarelo  <= '0';
				sinal_vermelho <= '0';
				night          <= '0';
				clear_contador <= '1';
				vetor_estado <= "011";
		 
				-- cálculo do próximo estado
				if (ativar_night ='1') then
					proximo_estado <= ESTADO_NIGHT;
				elsif (emergencia = '1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERDE;
				elsif ((outra_emergencia = '1') or (pedestre = '1')) then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
				else
					proximo_estado <= ESTADO_SINAL_VERDE;
				end if;

			when ESTADO_RESETAR_SINAL_VERMELHO =>
				sinal_verde    <= '0';
				sinal_amarelo  <= '0';
				sinal_vermelho <= '1';
				night          <= '0';
				clear_contador <= '1';
				vetor_estado <= "100";
		 
				-- cálculo do próximo estado
			   if (ativar_night ='1') then
					proximo_estado <= ESTADO_NIGHT;
			   elsif (emergencia = '1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERDE;
			   elsif (outra_emergencia = '1') then
					proximo_estado <= ESTADO_RESETAR_SINAL_VERMELHO;
			   else
					proximo_estado <= ESTADO_SINAL_VERMELHO;
			   end if;

            when ESTADO_NIGHT =>
					sinal_verde    <= '0';
					sinal_amarelo  <= '0';
					sinal_vermelho <= '0';
					night          <= '1';
					clear_contador <= '0';
					vetor_estado <= "101";
		 
					-- cálculo do próximo estado
					if (ativar_night = '1') then
						proximo_estado <= ESTADO_NIGHT;
						vetor_proximo_estado <= "101";
               elsif (ativar_night = '0') then
						proximo_estado <= ESTADO_SINAL_VERDE;
						vetor_proximo_estado <= "000";
               end if;

			when others =>
				sinal_verde    <= '0';
				sinal_amarelo  <= '0';
				sinal_vermelho <= '0';
				night          <= '0';
				clear_contador <= '0';
				vetor_estado <= "111";
			 
        end case;
    end process;
end architecture;
