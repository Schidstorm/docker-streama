FROM alpine as downloader

ARG STREAMA_VERSION=1.9.1

RUN apk update
RUN apk add curl
RUN curl https://github.com/streamaserver/streama/releases/download/v${STREAMA_VERSION}/streama-${STREAMA_VERSION}.jar > /streama.jar

FROM java:8-jre-alpine

RUN apk update && apk upgrade

RUN adduser -D -h /app streama
USER streama
WORKDIR /app
COPY --chown=streama:streama --from=downloader /streama.jar /app/streama.jar
RUN chmod +x /app/streama.jar

ENTRYPOINT [ "java", "-jar", "streama.jar" ]

