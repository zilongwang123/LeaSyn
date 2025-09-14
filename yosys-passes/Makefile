YOSYS_CONFIG ?= ../../yosys/yosys-config
CXXFLAGS=$(shell ../../yosys/yosys-config --cxxflags)
DATDIR=$(shell ../../yosys/yosys-config --datdir)

PASSES := addmodule stuttering show_regs_mems
OBJS := $(patsubst %,../%.so,${PASSES})

.PHONY: all clean
all: ${OBJS}

clean:
	rm -f ${OBJS}

../%.so: %.cc
	${YOSYS_CONFIG} --exec --cxx $(subst $(DATDIR),../../yosys/share,$(CXXFLAGS)) --ldflags -o $@ -shared $^ --ldlibs
	rm -f $(@:.so=.d)

../../yosys/yosys-config --exec --cxx -Wall -Wextra -ggdb -I../../yosys/share/include -MD -MP -D_YOSYS_ -fPIC -I/usr/local/include -std=c++17 -O3 -DYOSYS_ENABLE_READLINE -DYOSYS_ENABLE_PLUGINS -DYOSYS_ENABLE_GLOB -DYOSYS_ENABLE_ZLIB -I/usr/include/tcl8.6 -DYOSYS_ENABLE_TCL -DYOSYS_ENABLE_ABC -DYOSYS_ENABLE_COVER --ldflags -o ../show_regs_mems.so -shared show_regs_mems.cc --ldlibs