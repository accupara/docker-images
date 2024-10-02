# Taken from https://github.com/fly-apps/ollama-open-webui/blob/main/Dockerfile
# Stage 1: Build ollama service
FROM docker.io/ollama/ollama:latest@sha256:e458178cf2c114a22e1fe954dd9a92c785d1be686578a6c073a60cf259875470 AS ollama

# Stage 2: Build ollama-webui service and copy everything from ollama
# Taken from https://github.com/open-webui/open-webui/pkgs/container/open-webui/282434443?tag=git-0907c32-ollama
FROM ghcr.io/open-webui/open-webui:latest@sha256:b2262995f1dceed066324f4dbcca6f0971a197a66cfb5c55bfbe362242d4c1d2

COPY --from=ollama / /

RUN apt-get update && apt-get install -y sudo

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
    autoconf \
    automake \
    bash \
    bc \
    binutils \
    bison \
    build-essential \
    bzip2 \
    clang \
    cmake \
    cpio \
    curl \
    dialog \
    dos2unix \
    expect \
    git \
    jq \
    liblz4-tool \
    libncurses5-dev \
    libncurses5 \
    make \
    openssl \
    perl \
    python2 \
    python3 \
    python3-mako \
    schedtool \
    sed \
    squashfs-tools \
    tar \
    unzip \
    wget \
    xsltproc \
    zip \
    zlib1g-dev \
    zstd \
    iputils-arping \
    iputils-clockdiff \
    iputils-ping \
    iputils-tracepath \
    inetutils-tools \
&& sudo apt-get clean \
&& sudo rm -f /var/lib/apt/lists/*_dists_*

RUN useradd -ms /bin/bash admin && \
    echo "admin:admin" | chpasswd && \
    adduser admin sudo && \
    echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER admin
ENV HOME /home/admin

RUN sudo chown -R admin:admin /home/admin
RUN echo ". /etc/bash_completion" >> /home/admin/.bashrc && \
    echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc

# Make sure the user has access to the app and root directory
RUN chown -R $UID:$GID /app $HOME

WORKDIR /app/backend

COPY start.sh ./
RUN chmod +x start.sh

CMD ["./start.sh"]