FROM 32bit/ubuntu:14.04

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y \
        bash-completion \
        build-essential \
        git \
        subversion \
        vim \
        sudo

RUN echo ". /etc/bash_completion" >> /root/.bashrc

CMD /bin/bash

RUN useradd -ms /bin/bash admin && \
    echo "admin:admin" | chpasswd && \
    adduser admin sudo && \
    echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER admin
ENV HOME /home/admin
WORKDIR /home/admin

RUN sudo chown -R admin:admin /home/admin
RUN echo ". /etc/bash_completion" >> /home/admin/.bashrc && \
    echo "alias ls='ls --color' ; alias ll='ls -l'" >> /home/admin/.bashrc
