create_bd_design "function_generator"

# Add the clocks

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
set_property -dict [list CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} CONFIG.CLKOUT1_JITTER {125.247}] [get_bd_cells clk_wiz_0]
set_property -dict [list CONFIG.USE_SAFE_CLOCK_STARTUP {true} CONFIG.CLKOUT1_DRIVES {BUFGCE} CONFIG.CLKOUT2_DRIVES {BUFGCE} CONFIG.CLKOUT3_DRIVES {BUFGCE} CONFIG.CLKOUT4_DRIVES {BUFGCE} CONFIG.CLKOUT5_DRIVES {BUFGCE} CONFIG.CLKOUT6_DRIVES {BUFGCE} CONFIG.CLKOUT7_DRIVES {BUFGCE} CONFIG.FEEDBACK_SOURCE {FDBK_AUTO}] [get_bd_cells clk_wiz_0]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {Auto}}  [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
set_property name adc_clk [get_bd_intf_ports diff_clock_rtl_0]
endgroup


startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0_125M
endgroup

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps_7_0_axi_periph
set_property -dict [list CONFIG.NUM_MI {3} CONFIG.STRATEGY {1}] [get_bd_cells ps_7_0_axi_periph]
endgroup

startgroup
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0_125M/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0_125M/dcm_locked]
endgroup


startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0
set_property -dict [list CONFIG.C_BAUDRATE {115200}] [get_bd_cells axi_uartlite_0]

connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins axi_uartlite_0/s_axi_aclk]

make_bd_intf_pins_external [get_bd_intf_pins axi_uartlite_0/UART]
set_property NAME dbg_uart [get_bd_intf_ports /UART_0]
endgroup



connect_bd_intf_net [get_bd_intf_pins axi_uartlite_0/S_AXI] -boundary_type upper [get_bd_intf_pins ps_7_0_axi_periph/M00_AXI]



save_bd_design
