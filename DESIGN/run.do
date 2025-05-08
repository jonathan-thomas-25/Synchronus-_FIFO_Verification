vlog -f run.f +define+LEVEL2
vopt tb -o top_opt -designfile design.bin -debug
vsim -c top_opt -qwavedb=+signal+wavefile=qwave.db
