-- Arthur Coronho, Lucas Szuster Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_registrador_um_bits is
end entity;

architecture sim of tb_registrador_um_bits is
    signal clk : std_logic := '1';
    signal clk_enable : std_logic := '1';
    signal I : std_logic;
    signal Q : std_logic;
    signal reset : std_logic := '0';
    constant tempo : time := 10 ns;
begin
	-- inicializando a uut e realizando o port map
	uut: entity work.registrador_um_bit
  
    port map (
    	clk => clk,
        I => I,
        Q => Q,
        reset => reset
    );
    
    -- inicializando o pulso do clock
    clk <= clk_enable and not clk after tempo / 2;
    
    stim: process
    begin
    	-- estímulos iniciais
        I <= '0'; wait for tempo * 5;
        I <= '1'; wait for tempo * 5;
        I <= '0'; wait for tempo * 5;
        I <= '1'; wait for tempo * 5;
        
        -- ligando o reset
        reset <= '1'; 
        I <= '1'; 
        wait for tempo * 5;
        
        -- desligando o reset;
        reset <= '0';
        I <= '0'; wait for tempo * 5;
        I <= '1'; wait for tempo * 5;
        
        -- Terminando clock
        clk_enable <= '0';
    	wait;
    end process;
end architecture;
