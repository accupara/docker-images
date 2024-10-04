# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
# install as if this is regular Linux: https://github.com/ollama/ollama/blob/main/docs/linux.md
&& curl -fsSL https://ollama.com/install.sh | sudo bash \
# pick up the start.sh from https://github.com/fly-apps/ollama-open-webui
&& wget -O start.sh https://raw.githubusercontent.com/fly-apps/ollama-open-webui/refs/heads/main/start.sh \
&& sudo chmod +x start.sh \
&& sudo mv start.sh /bin/ \
# The usual cleanup
&& sudo apt-get clean \
&& sudo rm -f /var/lib/apt/lists/*_dists_*

WORKDIR /app/backend

CMD ["/bin/start.sh"]