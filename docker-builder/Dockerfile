FROM accupara/lkbuild:amd64

RUN sudo apt-get update \
    && sudo apt-get remove -y \
         docker \
         docker-engine \
         docker.io \
         containerd \
         runc \
    && sudo apt-get install -y \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg-agent \
         software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && sudo add-apt-repository \
         "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
         $(lsb_release -cs) \
         stable" \
    && sudo apt-get update \
    && sudo apt-get install -y \
         docker-ce \
         docker-ce-cli \
         containerd.io \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo addgroup admin docker
