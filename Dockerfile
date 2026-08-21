FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd, tini, and base tools directly via apt
RUN apt-get update && apt-get install -y --no-install-recommends \
    ttyd \
    tini \
    curl \
    wget \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 7681
WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "-p", "7681", "-W", "bash"]
