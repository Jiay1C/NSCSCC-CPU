set_property SRC_FILE_INFO {cfile:c:/Users/Microapple/Desktop/release_project/func_test_v0.01/soc_sram_func/rtl/xilinx_ip/clk_pll/clk_pll.xdc rfile:../../../rtl/xilinx_ip/clk_pll/clk_pll.xdc id:1 order:EARLY scoped_inst:pll.clk_pll/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/Microapple/Desktop/release_project/func_test_v0.01/soc_sram_func/run_vivado/soc_lite.xdc rfile:../../soc_lite.xdc id:2} [current_design]
current_instance pll.clk_pll/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
current_instance
set_property src_info {type:XDC file:2 line:91 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_clocks -of_objects [get_pins clk_pll/inst/plle2_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins clk_pll/inst/plle2_adv_inst/CLKOUT0]]
set_property src_info {type:XDC file:2 line:92 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_clocks -of_objects [get_pins clk_pll/inst/plle2_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins clk_pll/inst/plle2_adv_inst/CLKOUT1]]
