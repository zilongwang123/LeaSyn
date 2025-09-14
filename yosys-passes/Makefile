YOSYS_CONFIG ?= ../../tools/build/yosys/yosys-config
CXXFLAGS=$(shell ../../tools/build/yosys/yosys-config --cxxflags)
DATDIR=$(shell ../../tools/build/yosys/yosys-config --datdir)

PASSES := addmodule stuttering show_regs_mems
OBJS := $(patsubst %,../%.so,${PASSES})

.PHONY: all clean
all: ${OBJS}

clean:
	rm -f ${OBJS}

../%.so: %.cc
	${YOSYS_CONFIG} --exec --cxx $(subst $(DATDIR),../../tools/build/yosys/share,$(CXXFLAGS)) --ldflags -o $@ -shared $^ --ldlibs
	rm -f $(@:.so=.d)

