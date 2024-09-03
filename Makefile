# vhdl files
FILES = source/*

# testbench
TESTBENCHPATH = testbench/${TESTBENCHFILE}*
TESTBENCHFILE = ${TESTBENCH}_tb
WORKDIR = work
OUTDIR 	= out

#GHDL CONFIG
GHDL_CMD = ghdl
GHDL_FLAGS  = --ieee=synopsys --warn-no-vital-generic --workdir=$(WORKDIR) --std=08

STOP_TIME = 1000ms
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

# WAVEFORM_VIEWER = flatpak run io.github.gtkwave.GTKWave
WAVEFORM_VIEWER = gtkwave

.PHONY: clean

all: clean make run
# all: clean make run view

make:
ifeq ($(strip $(TESTBENCH)),)
	@echo "TESTBENCH not set. Use TESTBENCH=<value> to set it."
	@exit 1
endif

	@mkdir -p $(WORKDIR)
	@$(GHDL_CMD) -a $(GHDL_FLAGS) $(FILES)
	@$(GHDL_CMD) -a $(GHDL_FLAGS) $(TESTBENCHPATH)
	@$(GHDL_CMD) -e $(GHDL_FLAGS) $(TESTBENCHFILE)

run:
	@$(GHDL_CMD) -r $(GHDL_FLAGS) --workdir=$(WORKDIR) $(TESTBENCHFILE) --vcd=out.vcd $(GHDL_SIM_OPT)
	@mv $(TESTBENCHFILE) $(WORKDIR)/
	@mv e~$(TESTBENCHFILE).o $(WORKDIR)/

# view:
# 	@$(WAVEFORM_VIEWER) --dump=$(WORKDIR)/$(TESTBENCHFILE).vcd

clean:
	@rm -rf $(WORKDIR)