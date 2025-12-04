-- Arthur Coronho, Lucas Szuster, Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_contador_n is
end entity;

architecture sim of tb_contador_n is
	-- declarações de signals necessários
	constant N : integer := 4;
    signal clear_contador : std_logic := '0';
    signal count : std_logic;
    signal clk : std_logic := '1';
    signal clk_enable : std_logic := '1';
    constant tempo : time := 10 ns;
begin
	-- inicializando a uut e realizando o port map
	uut: entity work.contador_n
    generic map (
    	N => N
    )
    
    port map (
        clear_contador => clear_contador,
        clk => clk,
        count => count
    );
    
    -- inicializando o pulso do clock
    clk <= clk_enable and not clk after tempo / 2;
    
    stim: process
    begin
		-- teste inicial
        wait for tempo * 20;
        
        -- ligar o clear_contador
        clear_contador <= '1';
        wait for tempo * 20;
        
        -- desligar o clear_contador
        clear_contador <= '0';
        wait for tempo * 20;

		--terminar o clock
        clk_enable <= '0';
		
		-- fim da simulação
        wait; 
    end process;    
end architecture;
