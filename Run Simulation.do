vlib work
vlog RegOrNot_MuxInputs.v Mux_2to1.v Mux_4to1.v Adder_Subtractor.v Multiplier.v Spartan6_DSP48A1.v Spartan6_DSP48A1_tb.v
vsim -voptargs=+acc work.Spartan6_DSP48A1_tb
add wave *
run -all
#quit -sim