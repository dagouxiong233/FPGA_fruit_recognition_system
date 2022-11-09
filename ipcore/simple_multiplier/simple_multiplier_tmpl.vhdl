-- Created by IP Generator (Version 2020.3 build 62942)
-- Instantiation Template
--
-- Insert the following codes into your VHDL file.
--   * Change the_instance_name to your own instance name.
--   * Change the net names in the port map.


COMPONENT simple_multiplier
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    p : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;


the_instance_name : simple_multiplier
  PORT MAP (
    a => a,
    b => b,
    clk => clk,
    rst => rst,
    ce => ce,
    p => p
  );
