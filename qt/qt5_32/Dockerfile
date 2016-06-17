FROM uvatbc/ubuntu:14.04_32

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        binutils \
        libphonon-dev \
        libqt5webkit5-dev \
        libqt5xmlpatterns5-dev \
        libssl-dev \
        qt5-default \
        qtmultimedia5-dev
