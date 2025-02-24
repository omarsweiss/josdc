#----------------------------------------------------------------------
# SDC File for Dual_Issue Top-Level Design
# Target: High-Speed Operation (e.g., 200 MHz => 5 ns period)
#----------------------------------------------------------------------

#-----------------------------------------------------------
# Primary Clock Definition
#-----------------------------------------------------------
# Create a primary clock on the 'clk' port with a 5 ns period.
create_clock -name clk -period 12 [get_ports clk]

#-----------------------------------------------------------
# Input Delay Constraints
#-----------------------------------------------------------
# Apply input delay constraints for external signals.
set_input_delay -clock clk -max 0.5 [get_ports rst]

#-----------------------------------------------------------
# Output Delay Constraints
#-----------------------------------------------------------
# Constrain the outputs so the tools optimize for the fastest paths.
set_output_delay -clock clk -max 0.5 [get_ports out1]
set_output_delay -clock clk -max 0.5 [get_ports out2]

#-----------------------------------------------------------
# False Path Constraints
#-----------------------------------------------------------
# Mark asynchronous reset as a false path to prevent it from affecting timing.
set_false_path -from [get_ports rst] -to [get_registers]

#-----------------------------------------------------------
# Optional: Multi-Cycle Path Constraints
#-----------------------------------------------------------
# (Uncomment and adjust if any internal signals intentionally take >1 cycle.)
# set_multicycle_path -setup 2 -from [get_registers <source_reg>] -to [get_registers <dest_reg>]

# End of SDC File
