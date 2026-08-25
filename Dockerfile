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

EXPOSE 8080 7681
WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]

# Listens on $PORT assigned by host, or defaults to 8080
CMD ["sh", "-c", "exec ttyd -W -i 0.0.0.0 -p ${PORT:-8080} bash"]
