FROM uvatbc/ubuntu:14.04

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get -y install \
        binutils \
        libphonon-dev \
        libqt4-dev \
        libssl-dev

