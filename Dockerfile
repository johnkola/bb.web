FROM alpine:latest
RUN apk update && \
	apk upgrade && \
	apk upgrade musl && \
	apk upgrade openssl
RUN apk add openjdk8=8.275.01-r0
ARG JAR_FILE
ADD $JAR_FILE /app.jar
RUN echo "ARGS is $JAR_FILE"
RUN chmod 775 /app.jar
EXPOSE 8080
CMD java -jar /app.jar server /config.yml
