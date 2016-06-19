FROM accupara/ubuntu:14.04
RUN sudo ln -svf /bin/bash /bin/sh
RUN sudo apt-get update
RUN sudo apt-get install -y libc6-dev libc-dev bison build-essential libz-dev openjdk-6-jdk subversion patch gawk texinfo ncurses-dev curl wget gettext
ADD [".", "/mnt/"]
RUN cd /mnt && make setup
RUN cd /mnt && . ~/.bashrc && make sources
