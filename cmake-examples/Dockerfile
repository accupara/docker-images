FROM accupara/lkbuild:amd64

RUN sudo apt-get update && \
    sudo apt-get install -y \
      cmake \
      libboost-all-dev \
      libprotobuf-dev \
      protobuf-compiler \
      cppcheck \
      clang-3.6 \
      ninja-build \
      python3 \
      python3-pip && \
    sudo pip3 install conan

RUN wget https://github.com/danmar/cppcheck/archive/1.79.tar.gz \
 && tar xvf 1.79.tar.gz \
 && cd cppcheck-1.79 \
 && mkdir build \
 && cd build \
 && cmake .. \
 && sudo make install \
 && cd ~/ \
 && rm -rf cppcheck-1.79 \
 && rm -f 1.79.tar.gz
