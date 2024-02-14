FROM alpine:edge

RUN apk --no-cache upgrade && apk add --no-cache chromium
RUN apk add --no-cache nodejs npm
RUN npm install --global pm2
RUN npm install --global html-pdf-chrome@0.8.4

# Search these folder(s) for node modules: https://stackoverflow.com/a/55837716
ENV NODE_PATH=/usr/local/lib/node_modules:/usr/lib/node_modules/npm/node_modules

COPY export.js /export.js
RUN chmod +x /export.js

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

STOPSIGNAL SIGKILL

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["node", "/export.js"]
