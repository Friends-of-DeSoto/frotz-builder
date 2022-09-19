FROM ubuntu:20.04

COPY Makefile Makefile

# Install apt dependencies
RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl wget apt-utils python3 python3-pip make build-essential locales openssl git jq tzdata sudo lsb-release golang \
    && python3 -m pip install --upgrade --force pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/local/bin/python \
    && OS=$(uname | tr [[:upper:]] [[:lower:]]) \
    && if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then ARCH=arm64; else ARCH=amd64; fi \
    && YQ_VERSION=$(curl --silent "https://api.github.com/repos/mikefarah/yq/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') \
    && wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${OS}_${ARCH} -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq \
    && make
