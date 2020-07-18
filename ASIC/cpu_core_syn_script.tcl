# Processor core synthesis script for Cadence Genus
# Standard Cell Library selection

set_db lib_search_path /work/kits/tsmc/lib/90lp/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn90lpbwp14t_211a 
set_db library {tcbn90lpbwp14ttc.lib} 

# Reading Verilog Codes and Elaborating
read_hdl -v2001 {cpu_core.v program_counter.v register_file.v data_memory.v ALU.v instruction_memory.v control_unit.v}
elaborate cpu_core

# Defining Time Constraints
create_clock -period 100000 -name clkin1 -domain domain_1 clk0
set_clock_latency -max 1000 clkin1
# CLOCK UNCERTAINTY (JITTER) 
set_clock_uncertainty -setup 100 clkin1
set_clock_uncertainty -hold 100 clkin1                     

set_input_delay 200 [all_inputs] -clock clkin1

set_driving_cell reset -cell BUFFPD12BWP14T

# Synthesizing
set_db operating_conditions NCCOM

set_db syn_generic_effort high
set_db syn_map_effort high
set_db syn_opt_effort high

  
syn_generic cpu_core
syn_map cpu_core
syn_opt cpu_core


# Writing Report Files
report timing > report_time.txt
report gates > report_gates.txt
report area > report_area.txt

# Writing Design Files
write_hdl cpu_core -language v2001 > syn_cpu_core.v
write_sdf -edges check_edge -design cpu_core > cpu_core.sdf
