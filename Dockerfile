FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tini \
    wget \
    git \
    vim \
    && curl -sL https://github.com/sorenisanerd/gotty/releases/download/v1.5.0/gotty_v1.5.0_linux_amd64.tar.gz | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/gotty \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 7681
WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["gotty", "-w", "-p", "7681", "bash"]
