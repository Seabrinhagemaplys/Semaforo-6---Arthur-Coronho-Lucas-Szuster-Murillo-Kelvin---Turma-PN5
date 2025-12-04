-- Arthur Coronho, Lucas Szuster, Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_calcular_virar_a_direita is
end entity;

architecture sim of tb_calcular_virar_a_direita is
    -- declarações de signals necessários
    signal pedestre           : std_logic;
    signal outro_pedestre     : std_logic;
    signal virar_a_direita    : std_logic;
    signal emergencia         : std_logic;
    signal outra_emergencia   : std_logic;
    constant tempo            : time := 10 ns;

begin
    -- inicializando a uut e realizando o port map
    uut: entity work.calcular_virar_a_direita
        port map (
            pedestre => pedestre,
            outro_pedestre => outro_pedestre,
            emergencia => emergencia,
            outra_emergencia => outra_emergencia,
            virar_a_direita => virar_a_direita
        );

    stim: process
    begin
        -- teste 1: 0 0 0 0
        pedestre <= '0';
        outro_pedestre <= '0';
        emergencia <= '0';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 2: 0 0 0 1
        pedestre <= '0';
        outro_pedestre <= '0';
        emergencia <= '0';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 3: 0 0 1 0
        pedestre <= '0';
        outro_pedestre <= '0';
        emergencia <= '1';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 4: 0 0 1 1
        pedestre <= '0';
        outro_pedestre <= '0';
        emergencia <= '1';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 5: 0 1 0 0
        pedestre <= '0';
        outro_pedestre <= '1';
        emergencia <= '0';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 6: 0 1 0 1
        pedestre <= '0';
        outro_pedestre <= '1';
        emergencia <= '0';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 7: 0 1 1 0
        pedestre <= '0';
        outro_pedestre <= '1';
        emergencia <= '1';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 8: 0 1 1 1
        pedestre <= '0';
        outro_pedestre <= '1';
        emergencia <= '1';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 9: 1 0 0 0
        pedestre <= '1';
        outro_pedestre <= '0';
        emergencia <= '0';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 10: 1 0 0 1
        pedestre <= '1';
        outro_pedestre <= '0';
        emergencia <= '0';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 11: 1 0 1 0
        pedestre <= '1';
        outro_pedestre <= '0';
        emergencia <= '1';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 12: 1 0 1 1
        pedestre <= '1';
        outro_pedestre <= '0';
        emergencia <= '1';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 13: 1 1 0 0
        pedestre <= '1';
        outro_pedestre <= '1';
        emergencia <= '0';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 14: 1 1 0 1
        pedestre <= '1';
        outro_pedestre <= '1';
        emergencia <= '0';
        outra_emergencia <= '1';
        wait for tempo;

        -- teste 15: 1 1 1 0
        pedestre <= '1';
        outro_pedestre <= '1';
        emergencia <= '1';
        outra_emergencia <= '0';
        wait for tempo;

        -- teste 16: 1 1 1 1
        pedestre <= '1';
        outro_pedestre <= '1';
        emergencia <= '1';
        outra_emergencia <= '1';
        wait for tempo;

        -- fim da simulação
        wait;
    end process;
end architecture;
