FROM node:14-buster-slim

# Needed for npm dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.7 \
    make \
    gcc \
    g++ \
    git \
    curl \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /var/cache/apt/archives/*.deb
  
ENV PYTHON="/usr/bin/python3.7"

# Install dependencies

WORKDIR /opt

COPY package.json .
COPY yarn.lock .
# Workaround for an issue with yarn and git
RUN git config --global url."https://github.com/".insteadOf ssh://git@github.com/ && \
    git config --global url."https://".insteadOf git://
RUN yarn install --frozen-lockfile

# COPY files required for deployment
COPY hardhat.config.ts .
COPY contracts contracts
COPY scripts scripts
COPY deployments/localhost deployments/localhost

EXPOSE 8545 3000

HEALTHCHECK --interval=10s --timeout=15s --start-period=60s --retries=6 \
  CMD curl -f http://localhost:3000 || exit 1

# Run the node by default
ENTRYPOINT yarn run start
