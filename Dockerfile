FROM alpine as downloader

RUN apk update
RUN apk add curl
RUN curl https://github.com/streamaserver/streama/releases/download/v${STREAMA_VERSION}/streama-${STREAMA_VERSION}.jar > /streama.jar

FROM java:8-jre-alpine

RUN apk update && apk upgrade

ARG STREAMA_VERSION

RUN adduser -D -h /app streama
USER streama
WORKDIR /app
COPY --chown=streama:streama --from=downloader /streama.jar /app/streama.jar
RUN chmod +x /app/streama.jar

ENTRYPOINT [ "java", "-jar", "streama.jar" ]

