FROM alpine
RUN apk update && apk add --no-cache dropbear tinyproxy bash
COPY docker/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
