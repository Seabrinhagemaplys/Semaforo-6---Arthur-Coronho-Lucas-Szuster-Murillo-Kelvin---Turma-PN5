library IEEE;
use IEEE.std_logic_1164.ALL;

entity tb_data_path is
end entity;

architecture arq of tb_data_path is
    -- Sinais para o UUT (Unit Under Test)
    signal clk : std_logic := '1';
    signal clk_enable : std_logic := '1';
    signal clear : std_logic := '0';
    signal pedestre : std_logic := '0';
    signal outro_pedestre : std_logic := '0';
    signal emergencia : std_logic := '0';
    signal outra_emergencia : std_logic := '0';
    signal sinal_verde : std_logic := '0';
    signal sinal_amarelo : std_logic := '0';
    signal sinal_vermelho : std_logic := '0';
    signal ativar_night : std_logic := '0';
    signal resetar_contador : std_logic := '0';

    -- Sinais de saída
    signal led_virar_a_direita : std_logic;
    signal led_sinal_vermelho : std_logic;
    signal led_sinal_amarelo : std_logic;
    signal led_sinal_verde : std_logic;
    signal count : std_logic;

    -- Constantes
    constant tempo : time := 100 us;
begin
    -- inicializando a uut e realizando o port map
    uut: entity work.data_path
    port map (
     	pedestre => pedestre,
        outro_pedestre => outro_pedestre,
        emergencia => emergencia,
        outra_emergencia => outra_emergencia,
        sinal_verde => sinal_verde,
        sinal_amarelo => sinal_amarelo,
        sinal_vermelho => sinal_vermelho,
        ativar_night => ativar_night,
        resetar_contador => resetar_contador,
        clk => clk,
        clear => clear,
        led_virar_a_direita => led_virar_a_direita,
        led_sinal_vermelho => led_sinal_vermelho,
        led_sinal_amarelo => led_sinal_amarelo,
        led_sinal_verde => led_sinal_verde,
        count => count
    );

    -- Geração do clock
	clk <= clk_enable and not clk after tempo / 2;

    -- Processo de estímulos (testes)
    sp: process
    begin
        -- Inicialização dos sinais
        clear <= '1';  -- Ativa reset
        pedestre <= '0';
        outro_pedestre <= '0';
        emergencia <= '0';
        outra_emergencia <= '0';
        sinal_verde <= '0';
        sinal_amarelo <= '0';
        sinal_vermelho <= '0';
        ativar_night <= '0';
        resetar_contador <= '0';

        -- Aguardar 2 períodos de clock
        wait for tempo * 2;
        clear <= '0';  -- Desativa reset

        -- Teste 1: Teste com o sinal verde ativo
        sinal_verde <= '1';
        wait for tempo * 2;

        -- Teste 2: Teste com o sinal amarelo ativo
        sinal_amarelo <= '1';
        wait for tempo * 2;

        -- Teste 3: Teste com o sinal vermelho ativo
        sinal_vermelho <= '1';
        wait for tempo * 2;

        -- Teste 4: Teste com pedestre ativo
        pedestre <= '1';
        wait for tempo * 2;

        -- Teste 5: Teste com emergência ativa
        emergencia <= '1';
        wait for tempo * 2;

        -- Teste 6: Teste com o sinal verde e o ativar_night ativo
        sinal_verde <= '1';
        ativar_night <= '1';
        wait for tempo * 2;

        -- Teste 7: Teste com todos os sinais de pedestres e emergência
        pedestre <= '1';
        outro_pedestre <= '1';
        emergencia <= '1';
        outra_emergencia <= '1';
        wait for tempo * 2;

        -- Finalizando o teste
        -- Terminando clock
        clk_enable <= '0';
        wait;
    end process;
end architecture;
