-- Arthur Coronho, Lucas Szuster Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity bloco_or is 
    port(
      -- Entradas  
      clear_assincrono : in std_logic;
      entrada_um       : in std_logic;
      entrada_dois     : in std_logic;
      
      -- Saída
      saida        : out std_logic
    );
end bloco_or;

architecture arq of bloco_or is
    begin
    	 -- procedimento do OR
  		saida <= '0' when clear_assincrono = '1' else
        entrada_um or entrada_dois;
end architecture;
