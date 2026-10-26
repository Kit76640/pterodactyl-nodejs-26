# Floating tag: always the latest Node 26 patch on the latest Debian stable (slim)
FROM node:26-trixie-slim

LABEL org.opencontainers.image.source="https://github.com/Kit76640/pterodactyl-nodejs-26" \
      org.opencontainers.image.description="Node.js 26 with git for Pterodactyl"

ENV DEBIAN_FRONTEND=noninteractive

# Apply all pending OS security patches at build time
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get install -y --no-install-recommends \
      git ca-certificates curl tar unzip tini openssl \
      build-essential python3 \
      ffmpeg iproute2 dnsutils \
 && apt-get -y autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Pterodactyl expects a user named container (like yolks)
# The base image already has uid 1000 (node), so rename/replace it
RUN userdel -r node 2>/dev/null || true \
 && useradd -m -d /home/container -s /bin/bash container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/bin/bash", "/entrypoint.sh"]
