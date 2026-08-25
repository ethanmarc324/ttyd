FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tini \
    wget \
    git \
    vim \
    ttyd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]

# Added -i 0.0.0.0 and -t pingInterval=10 to prevent WebSocket drops
CMD ["sh", "-c", "exec ttyd -W -i 0.0.0.0 -p ${PORT:-7681} -t pingInterval=10 bash"]
