# Build n8n with Puppeteer Stealth support
# Use node:20-bookworm-slim (Debian 12, active repos)
FROM node:20-bookworm-slim

# Install system dependencies for Chromium
RUN apt-get update && apt-get install -y \
    chromium \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install n8n globally
RUN npm install -g n8n

# Install puppeteer packages globally
RUN npm install -g puppeteer-extra@3.3.4 puppeteer-extra-plugin-stealth@2.11.2 puppeteer-core puppeteer-extra-plugin-user-preferences puppeteer-extra-plugin-user-data-dir

# Create node user and n8n data directory
RUN useradd -m -u 1000 node 2>/dev/null || true
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

# Set Chromium environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

USER node
WORKDIR /home/node

EXPOSE 5678

CMD ["n8n", "start"]
