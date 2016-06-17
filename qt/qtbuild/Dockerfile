FROM uvatbc/ubuntu:14.04

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        binutils \
        bison \
        flex \
        git \
        gperf \
        libasound2-dev \
        libfontconfig1-dev \
        libglu1-mesa-dev \
        libgstreamer0.10-dev \
        libgstreamer-plugins-base0.10-dev \
        libicu-dev \
        libphonon-dev \
        libssl-dev \
        libx11-xcb-dev \
        "^libxcb.*" \
        libxcursor-dev \
        libxcomposite-dev \
        libxdamage-dev \
        libxi-dev \
        libxslt-dev \
        libxrandr-dev \
        libxrender-dev \
        perl \
        python \
        subversion \
        ruby
RUN sudo apt-get build-dep -y qt5-default
