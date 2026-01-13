# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM ghcr.io/open-webui/open-webui:latest AS oui

FROM accupara/debian:12

COPY --from=oui /app/ /app/
WORKDIR /app/backend

ENV ENV=prod \
    PORT=8080 \
# pass build args to the build
    USE_OLLAMA_DOCKER=false \
    USE_CUDA_DOCKER=false \
    USE_CUDA_DOCKER_VER=cu121 \
    USE_EMBEDDING_MODEL_DOCKER=sentence-transformers/all-MiniLM-L6-v2 \
    USE_RERANKING_MODEL_DOCKER= \
    RAG_EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2 \
    SENTENCE_TRANSFORMERS_HOME=/app/backend/data/cache/embedding/models \
    WHISPER_MODEL=base \
    WHISPER_MODEL_DIR=/app/backend/data/cache/whisper/models

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
# From: https://github.com/open-webui/open-webui/blob/main/Dockerfile
&& sudo apt-get update \
# Prepare to use pip, and let pip break system packages because this is a docker container image
&& sudo apt-get install -y \
    python3-full \
    python3-pip \
&& sudo python3 -m pip config set global.break-system-packages true \
# Install pandoc and netcat
&& sudo apt-get install -y --no-install-recommends curl netcat-openbsd pandoc \
&& sudo apt-get install -y --no-install-recommends python3-dev \
# for RAG OCR
&& sudo apt-get install -y --no-install-recommends ffmpeg libsm6 libxext6 \
# install helper tools
&& sudo apt-get install -y --no-install-recommends curl jq \
# Python3 pip deps
&& sudo python3 -m pip install uv \
# If you use CUDA the whisper and embedding model will be downloaded on first use
&& sudo python3 -m pip install --break-system-packages \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/$USE_CUDA_DOCKER_VER --no-cache-dir \
&& sudo uv pip install --break-system-packages --system -r /app/backend/requirements.txt --no-cache-dir \
&& sudo -E python3 -c "import os; from sentence_transformers import SentenceTransformer; SentenceTransformer(os.environ['RAG_EMBEDDING_MODEL'], device='cpu')" \
&& sudo -E python3 -c "import os; from faster_whisper import WhisperModel; WhisperModel(os.environ['WHISPER_MODEL'], device='cpu', compute_type='int8', download_root=os.environ['WHISPER_MODEL_DIR'])" \
# If you don't use CUDA, install this stuff
&& sudo python3 -m pip install --break-system-packages \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --no-cache-dir \
&& sudo uv pip install --break-system-packages --system -r /app/backend/requirements.txt --no-cache-dir \
&& sudo -E python3 -c "import os; from sentence_transformers import SentenceTransformer; SentenceTransformer(os.environ['RAG_EMBEDDING_MODEL'], device='cpu')" \
&& sudo -E python3 -c "import os; from faster_whisper import WhisperModel; WhisperModel(os.environ['WHISPER_MODEL'], device='cpu', compute_type='int8', download_root=os.environ['WHISPER_MODEL_DIR'])" \

# for gpu support?
&& sudo pip install unsloth "xformers==0.0.28.post2" --break-system-packages \
&& sudo pip uninstall unsloth -y --break-system-packages \
&& sudo pip install --upgrade --no-cache-dir "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git" --break-system-packages \
&& sudo apt install libnccl2 libnccl-dev cudnn9-cuda-12 -y \
# The usual cleanup
&& cd /tmp \
&& sudo find dl -delete \
&& sudo apt-get clean \
&& sudo rm -f /var/lib/apt/lists/*_dists_*

WORKDIR /app/backend

# just copy pasted
HEALTHCHECK CMD curl --silent --fail http://localhost:${PORT:-8080}/health | jq -ne 'input.status == true' || exit 1

CMD ["/bin/start.sh"]