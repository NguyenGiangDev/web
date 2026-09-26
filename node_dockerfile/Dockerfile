FROM node:20-alpine
RUN apk add --no-cache tini && \
    addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app
ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev

COPY --chown=appuser:appgroup . .

RUN mkdir -p data && chown appuser:appgroup /app/data

# docker-entrypoint.sh: tạo các subdir sau khi volume được mount
# (build-time mkdir bị ghi đè bởi volume mount nên phải tạo lại lúc runtime)
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER appuser
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/ || exit 1

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
CMD ["node", "server.js"]