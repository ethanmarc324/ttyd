FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tini \
    wget \
    git \
    vim \
    && ARCH=$(dpkg --print-architecture) \
    && curl -sL "https://github.com/sorenisanerd/gotty/releases/download/v1.5.0/gotty_v1.5.0_linux_${ARCH}.tar.gz" | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/gotty \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "-c", "exec gotty -w -p ${PORT:-7681} bash"]
