set bd_name "axi_gpio"

create_bd_design $bd_name

set processing_system [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7 ]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" } $processing_system


set axi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio ]
set_property -dict [list CONFIG.C_GPIO_WIDTH {8} CONFIG.C_ALL_OUTPUTS {1}] $axi_gpio


apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { \
    Clk_master {/processing_system7/FCLK_CLK0 (125 MHz)} \
    Clk_slave {/processing_system7/FCLK_CLK0 (125 MHz)} \
    Clk_xbar {/processing_system7/FCLK_CLK0 (125 MHz)} \
    Master {/processing_system7/M_AXI_GP0} \
    Slave {/axi_gpio/S_AXI} \
    intc_ip {New AXI Interconnect} \
    master_apm {0}
}  [get_bd_intf_pins axi_gpio/S_AXI]

apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {Auto}}  [get_bd_intf_pins axi_gpio/GPIO]
set_property NAME leds [get_bd_intf_ports /gpio_rtl_0]

save_bd_design

set bd_path get_files[get_property FILE_NAME [current_bd_design]]
