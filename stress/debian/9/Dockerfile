FROM accupara/debian:9

RUN sudo apt-get update \
    && sudo apt-get install -y stress \
    && sudo apt-get clean \
    && sudo rm -f /var/lib/apt/lists/*_dists_*
