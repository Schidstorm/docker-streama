FROM java:8-jre-alpine

ARG STREAMA_VERSION

RUN adduser -D -h /app streama
USER streama
WORKDIR /app
RUN curl https://github.com/streamaserver/streama/releases/download/v${STREAMA_VERSION}/streama-${STREAMA_VERSION}.jar > /app/streama.jar
RUN chmod +x /app/streama.jar

ENTRYPOINT [ "java", "-jar", "streama.jar" ]

