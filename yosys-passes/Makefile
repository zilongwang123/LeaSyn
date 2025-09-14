YOSYS_CONFIG ?= ../../tools/yosys/yosys-config
CXXFLAGS=$(shell ../../tools/yosys/yosys-config --cxxflags)
DATDIR=$(shell ../../tools/yosys/yosys-config --datdir)

PASSES := addmodule stuttering show_regs_mems
OBJS := $(patsubst %,../%.so,${PASSES})

.PHONY: all clean
all: ${OBJS}

clean:
	rm -f ${OBJS}

../%.so: %.cc
	${YOSYS_CONFIG} --exec --cxx $(subst $(DATDIR),../../tools/yosys/share,$(CXXFLAGS)) --ldflags -o $@ -shared $^ --ldlibs
	rm -f $(@:.so=.d)

