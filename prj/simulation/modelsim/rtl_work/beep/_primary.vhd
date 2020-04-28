library verilog;
use verilog.vl_types.all;
entity beep is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 0);
        beep_out        : out    vl_logic
    );
end beep;
