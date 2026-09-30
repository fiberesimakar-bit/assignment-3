FROM alpine:latest

RUN apk add --no-cache bash

COPY app /app

RUN chmod +x /app/app.sh

ENTRYPOINT ["/app/app.sh"]