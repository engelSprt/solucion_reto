library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
      Port (
          clock : in std_logic;
          reset : in std_logic;
          miso : in std_logic;
          rx : in std_logic; 
          ss_n : buffer STD_LOGIC_VECTOR(0 DOWNTO 0);
          s_clk : buffer std_logic; 
          mosi : out std_logic;
          tx : out std_logic
       );
end top_level;

architecture Behavioral of top_level is

        signal temp_Q : STD_LOGIC_VECTOR(7 downto 0); 
        signal temp_salMux : STD_LOGIC_VECTOR(7 downto 0); 
        signal temp_outPortPB : std_logic_vector(7 downto 0);
        signal temp_portId : std_logic_vector(7 downto 0);
        signal temp_writeStrobe : std_logic;
        signal temp_outPortSPI : std_logic_vector(7 downto 0);
        signal temp_outPortUART : std_logic_vector(7 downto 0);


    component embedded_kcpsm6 is
    port (                   
                                in_port : in std_logic_vector(7 downto 0);
                                out_port : out std_logic_vector(7 downto 0);
                                port_id : out std_logic_vector(7 downto 0);
                            write_strobe : out std_logic;
                        --k_write_strobe : out std_logic;
                            -- read_strobe : out std_logic;
                            --interrupt : in std_logic;
                        --interrupt_ack : out std_logic;
                            --    sleep : in std_logic;
                                    clk : in std_logic;
                                    rst : in std_logic);
    end component;


    component registro_puerto_entrada is
        generic(
                n : integer := 8			--ancho del registro
        );
    Port ( 
                CLK  : in  STD_LOGIC;
                RST  : in  STD_LOGIC;
                D  : in  STD_LOGIC_VECTOR(n-1 downto 0);
                Q  : out STD_LOGIC_VECTOR(n-1 downto 0)
            );
    end component;

    component modulo_uart is
        Port ( 
                         CLK : in STD_LOGIC;
                         RST : in STD_LOGIC;
                         --pines de comunicación con PicoBlaze
                     PORT_ID : in STD_LOGIC_VECTOR (7 downto 0);
                  INPUT_PORT : in STD_LOGIC_VECTOR (7 downto 0);
                 OUTPUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
                WRITE_STROBE : in STD_LOGIC;
                          --pines de comunicación serial
                          TX : out STD_LOGIC;
                          RX : in STD_LOGIC
                          );
    end component;

    component modulo_spi is
        Port (         CLK : in STD_LOGIC;
                       RST : in STD_LOGIC;
                   PORT_ID : in STD_LOGIC_VECTOR (7 downto 0);
               OUTPUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
                      MISO : in  STD_LOGIC;                     
                      SCLK : buffer STD_LOGIC;                      
                      SS_N : buffer STD_LOGIC_VECTOR(0 DOWNTO 0);  
                      MOSI : out    STD_LOGIC);
    end component;


begin
     
    temp_salMux <= temp_outPortSPI when (temp_portId (6)='1') else
    temp_outPortUART when  (temp_portId (4)='1') else
            (others => '0');

    picoblaze : embedded_kcpsm6 port map (
                                            in_port =>  temp_Q,
                                            out_port => temp_outPortPB,
                                            port_id => temp_portId ,
                                            write_strobe => temp_writeStrobe ,
                                            clk =>clock ,
                                            rst => reset
    );

    registro : registro_puerto_entrada port map(
                                                    CLK =>clock ,
                                                    RST => reset,
                                                    D => temp_salMux,
                                                    Q => temp_Q
                                                    
    );

    moduloUART : modulo_uart port map(
                                            CLK =>clock ,
                                            RST => reset,
                                            PORT_ID => temp_portId,
                                            INPUT_PORT => temp_outPortPB ,
                                            OUTPUT_PORT => temp_outPortUART,
                                            WRITE_STROBE => temp_writeStrobe ,
                                            TX => tx ,
                                            RX => rx
        
    );

    moduloSPI : modulo_spi port map(
                                        CLK =>clock ,
                                        RST => reset, 
                                        PORT_ID => temp_portId,
                                        OUTPUT_PORT => temp_outPortSPI ,
                                        MISO => miso ,
                                        SCLK => s_clk ,
                                        SS_N => ss_n,
                                        MOSI => mosi 
    );


end Behavioral;
