# Используем образ n8n как основу
FROM n8nio/n8n:latest

USER root

# Устанавливаем браузер и зависимости
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Устанавливаем плагины для скрытия бота
RUN npm install -g puppeteer-extra puppeteer-extra-plugin-stealth

# Прописываем путь к браузеру
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
