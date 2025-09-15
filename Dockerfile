FROM ubuntu:latest

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get install -y \
                     build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python3 libftdi-dev gperf \
                     libboost-program-options-dev autoconf libgmp-dev \
                     cmake curl cmake ninja-build g++ python3-dev python3-setuptools \
                     python3-pip autoconf gperf \
                     gcc-11 g++-11 tclsh ant default-jre swig google-perftools libgoogle-perftools-dev \
                     python3-dev uuid uuid-dev libfl-dev wget python3-orderedmultidict \
                     nano openjdk-21-jre-headless openjdk-21-dbg maven tcl-dev

WORKDIR /home/yosys
RUN mkdir tools
WORKDIR /home/yosys/tools

RUN git clone https://github.com/YosysHQ/yosys.git yosys
WORKDIR /home/yosys/tools/yosys
RUN git submodule update --init
RUN git fetch --all --tags && git checkout v0.48
RUN git submodule update --init
RUN mkdir build
WORKDIR /home/yosys/tools/yosys/build
RUN make -j$(nproc) -f ../Makefile
RUN make install -f ../Makefile
WORKDIR /home/yosys/tools

RUN git clone https://github.com/YosysHQ/SymbiYosys.git SymbiYosys
WORKDIR /home/yosys/tools/SymbiYosys
RUN make -j$(nproc)
RUN make install
WORKDIR /home/yosys/tools

RUN git clone https://github.com/SRI-CSL/yices2.git yices2
WORKDIR /home/yosys/tools/yices2
RUN autoconf
RUN ./configure
RUN make -j$(nproc)
RUN make install
WORKDIR /home/yosys/tools

RUN curl -sSL https://get.haskellstack.org/ | sh
RUN git clone https://github.com/zachjs/sv2v.git
WORKDIR /home/yosys/tools/sv2v
RUN make -j$(nproc)
RUN stack install
WORKDIR /home/yosys/tools

RUN git clone https://github.com/steveicarus/iverilog.git
WORKDIR /home/yosys/tools/iverilog
RUN sh autoconf.sh
RUN ./configure
RUN make -j$(nproc)
RUN make install
WORKDIR /home/yosys/tools

WORKDIR /home/yosys
RUN git clone https://github.com/zilongwang123/LeaSyn.git
WORKDIR /home/yosys/tools

RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get install -y python3-lark
RUN mkdir /usr/local/share/yosys/plugins/

# COPY ./secretyosys /home/yosys/tools/secretyosys
# WORKDIR /home/yosys/tools/secretyosys/manual/verification/addmodule
# RUN make
# RUN cp addmodule.so /usr/local/share/yosys/plugins/
# WORKDIR /home/yosys/tools/secretyosys/manual/verification/show_regs_mems
# RUN make
# RUN cp show_regs_mems.so /usr/local/share/yosys/plugins/
# WORKDIR /home/yosys/tools/secretyosys/manual/verification/stuttering
# RUN make
# RUN cp stuttering.so /usr/local/share/yosys/plugins/

RUN cp /home/yosys/tools/sv2v/bin/sv2v /usr/local/bin

WORKDIR /home/yosys

CMD ["/bin/bash"]
