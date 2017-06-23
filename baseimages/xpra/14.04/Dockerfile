FROM accupara/ubuntu:14.04

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
COPY startcmd.sh /tmp/
RUN sudo apt-get install -y \
        binutils \
        openssh-server \
        python-pip \
        xpra \
 && mkdir -p ~/.ssh/ \
 && grep -v start-new-commands /etc/xpra/xpra.conf > /tmp/xpra.conf \
 && echo "start-new-commands = yes" >> /tmp/xpra.conf \
 && sudo mv /tmp/xpra.conf /etc/xpra/xpra.conf \
 && echo "alias xpra_start='xpra control :100 start'" >> ~/.bashrc

CMD /tmp/startcmd.sh
EXPOSE 22
