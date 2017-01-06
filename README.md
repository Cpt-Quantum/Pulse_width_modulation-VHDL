# Pulse_width_modulation-VHDL
This is a project to control the RGB LEDs on the Arty FPGA board via PWM. The code is written into separate modules with the PWM_test module being at the top of the hierarchy. The module is designed to be instantiated from another module above it. 

To control the colour displayed, each LED & colour gets a value between 0 and 255, which corresponds to its on time. A slower clock counts to 255 and resets the counters for each LED & colour.
