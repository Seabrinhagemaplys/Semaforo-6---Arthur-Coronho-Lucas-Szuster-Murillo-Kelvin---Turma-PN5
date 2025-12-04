-- Arthur Coronho Seabra Eiras, Lucas Araújo Campos Szuster, Murillo Kelvin
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    port(
        CLOCK_50   : in  std_logic;   -- Clock da placa DE2 (50 MHz)
        KEY        : in  std_logic_vector(3 downto 0); -- Botões
        SW         : in  std_logic_vector(9 downto 0); -- Chaves
        LEDR       : out std_logic_vector(17 downto 0); -- LEDs vermelhos
        LEDG       : out std_logic_vector(7 downto 0)  -- LEDs verdes
    );
end entity;

architecture RTL of top_level is
	signal clk                  : std_logic;
	signal reset_n              : std_logic;

   	-- sinais entre cotroladora e caminho de dados
	signal sinal_verde          : std_logic;
	signal sinal_amarelo        : std_logic;
	signal sinal_vermelho       : std_logic;
	signal night                : std_logic;
	signal clear_contador       : std_logic;
	signal sinal_count          : std_logic;
	
	signal vetor_estado         : std_logic_vector(2 downto 0);
	signal vetor_proximo_estado : std_logic_vector(2 downto 0);
	
	-- Declaração do divisor de clock
	component divisor_clock is
		port (
			CLOCK_50MHz : in std_logic;
			reset : in std_logic;
			CLOCK_1Hz : out std_logic
		);
	end component;
	 
	-- Declaração do datapath
	component data_path is
		port (
			--Entradas do Caminho de Dados
			pedestre               : in std_logic;
			outro_pedestre         : in std_logic;
			emergencia             : in std_logic;
			outra_emergencia       : in std_logic;
			sinal_verde            : in std_logic;
			sinal_amarelo          : in std_logic;
			sinal_vermelho         : in std_logic;
			ativar_night           : in std_logic;
			resetar_contador       : in std_logic;
			clk                    : in std_logic;
			clear                  : in std_logic;
			
			--Saídas do Caminho de Dados
			led_virar_a_direita    : out std_logic;
			led_sinal_vermelho     : out std_logic;
			led_sinal_amarelo      : out std_logic;
			led_sinal_verde        : out std_logic;
			count                  : out std_logic
		);
	end component;
	
	-- Declaração da controladora
	component controladora is
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
	end component;
	
begin
	-- reset
	reset_n <= SW(6);
	
	-- count
	LEDG(0) <= sinal_count;
	
	-- vetor proximo estados
	LEDG(7) <= vetor_estado(0);
	LEDG(6) <= vetor_estado(1);
	LEDG(5) <= vetor_estado(2);
	
	--Instância do divisor de clock
	div_clock: divisor_clock
	
	port map (
		CLOCK_50MHz => CLOCK_50,
		reset => reset_n,
		CLOCK_1Hz => clk
	);
	
	-- instância do caminho de dados
	caminho_de_dados: data_path
	port map (
		--Entradas externas do Caminho de Dados
		pedestre          => SW(0),
		outro_pedestre    => SW(1),
		emergencia        => SW(2),
		outra_emergencia  => SW(3),
		
		--Sinais intermediários
		sinal_verde       => sinal_verde,
		sinal_amarelo     => sinal_amarelo,
		sinal_vermelho    => sinal_vermelho,
		ativar_night      => SW(4),
		resetar_contador  => clear_contador,
		
		--clk e reset
		clk               => clk,
		clear             => reset_n,
		
		--Saídas do Caminho de Dados
		-- LEDs 
		led_virar_a_direita => LEDR(0),
		led_sinal_vermelho => LEDR(1),
		led_sinal_amarelo => LEDR(2),
		led_sinal_verde => LEDR(3),
		count => sinal_count 
	);
	
	-- instância de controladora
	C: controladora
	port map (
		--Entradas externas
		pedestre          => SW(0),
		outro_pedestre    => SW(1),
		emergencia        => SW(2),
		outra_emergencia  => SW(3),
		ativar_night      => SW(4),
					
		--clk e reset
		clk               => clk,
		reset             => reset_n,
			
		--Sinais intermediários para o datapah
		sinal_verde       => sinal_verde,
		sinal_amarelo     => sinal_amarelo,
		sinal_vermelho    => sinal_vermelho,
		night             => night,
		vetor_estado      => vetor_estado,
		vetor_proximo_estado => vetor_proximo_estado,
		count => sinal_count,
		clear_contador => clear_contador
	);
end RTL;
