# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
&& mkdir -p /tmp/dl && cd /tmp/dl \
# install as if this is regular Linux: https://github.com/ollama/ollama/blob/main/docs/linux.md
&& curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz \
&& sudo tar -C /usr -xzf ollama-linux-amd64.tgz \
# pick up the start.sh from https://github.com/fly-apps/ollama-open-webui
&& wget -O start.sh https://raw.githubusercontent.com/fly-apps/ollama-open-webui/refs/heads/main/start.sh \
&& sudo chmod +x start.sh \
&& sudo mv start.sh /bin/ \
# CUDA from here: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
&& wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
&& sudo dpkg -i cuda-keyring_1.1-1_all.deb \
&& sudo apt-get update \
&& sudo apt-get -y install \
    cuda-toolkit-12-6 \
# The usual cleanup
&& cd /tmp \
&& sudo find dl -delete \
&& sudo apt-get clean \
&& sudo rm -f /var/lib/apt/lists/*_dists_*

WORKDIR /app/backend

CMD ["/bin/start.sh"]