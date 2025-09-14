# YOSYS_CONFIG ?= ../../yosys/yosys-config
# CXXFLAGS=$(shell ../../yosys/yosys-config --cxxflags)
# DATDIR=$(shell ../../yosys/yosys-config --datdir)

# PASSES := addmodule stuttering show_regs_mems
# OBJS := $(patsubst %,../%.so,${PASSES})

# .PHONY: all clean
# all: ${OBJS}

# clean:
# 	rm -f ${OBJS}

# ../%.so: %.cc
# 	${YOSYS_CONFIG} --exec --cxx $(subst $(DATDIR),../../yosys/share,$(CXXFLAGS)) --ldflags -o $@ -shared $^ --ldlibs
# 	rm -f $(@:.so=.d)
YOSYS_CONFIG ?= yosys-config

PASSES := addmodule stuttering show_regs_mems
OBJS := $(patsubst %,../%.so,${PASSES})

.PHONY: all clean
all: ${OBJS}

clean:
	rm -f ${OBJS}

../%.so: %.cc
	${YOSYS_CONFIG} --build $@ $^
	rm -f $(@:.so=.d)