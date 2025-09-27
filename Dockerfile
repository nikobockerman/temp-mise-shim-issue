FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    nodejs \
    npm \
    python3 \
    python-is-python3 \
    shellcheck \
    zstd \
    && rm -rf /var/lib/apt/lists/*

USER ubuntu
WORKDIR /home/ubuntu


ENV MISE_BIN_DIR=/home/ubuntu/_temp/bin
ENV MISE_DATA_DIR=/home/ubuntu/_temp/mise-data
ENV MISE_VERSION=v2025.9.16

RUN mkdir -p ${MISE_BIN_DIR}
RUN mkdir -p ${MISE_DATA_DIR}

RUN --mount=type=bind,source=install-mise.sh,target=/tmp/install-mise.sh \
    bash /tmp/install-mise.sh

ENV PATH="${MISE_DATA_DIR}/shims:${MISE_BIN_DIR}:${PATH}"
ENV MISE_TRUSTED_CONFIG_PATHS=/home/ubuntu/project

RUN mkdir project
