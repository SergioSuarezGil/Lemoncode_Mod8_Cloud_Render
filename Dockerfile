# ---- Build stage ----
FROM node:24-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/SergioSuarezGil/Portfolio.git .
RUN npm ci
RUN npm run build

# ---- Serve stage ----
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/templates/default.conf.template
ENV PORT=10000
EXPOSE 10000
CMD ["/bin/sh", "-c", "envsubst '$$PORT' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
