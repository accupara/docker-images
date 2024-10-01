# Taken from https://github.com/fly-apps/ollama-open-webui/blob/main/Dockerfile
# Stage 1: Build ollama service
FROM ollama/ollama@sha256:e458178cf2c114a22e1fe954dd9a92c785d1be686578a6c073a60cf259875470 AS ollama

# Stage 2: Build ollama-webui service and copy everything from ollama
# Taken from https://github.com/open-webui/open-webui/pkgs/container/open-webui/282434443?tag=git-0907c32-ollama
FROM ghcr.io/open-webui/open-webui:git-0907c32-ollama

COPY --from=ollama / /

WORKDIR /app/backend

COPY start.sh ./
RUN chmod +x start.sh

CMD ["./start.sh"]