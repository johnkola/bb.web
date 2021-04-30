FROM openjdk:8-jdk-alpine
LABEL maintainer="john.kolahdouzan@gmail.com"
COPY ${JAR_FILE} app.jar
CMD ["echo", '${JAR_FILE}']
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
CMD ["echo", "Dockerfile last line"]

FROM alpine:latest
RUN apk update && \
	apk upgrade && \
	apk upgrade musl && \
	apk upgrade openssl
RUN apk add openjdk8=8.275.01-r0
ADD ./ca.cooperators.itsdpnc.itpnccreditcardprocessingeihapp/itpnccreditcardprocessingeihapp/0.0.1-SNAPSHOT/itpnccreditcardprocessingeihapp-0.0.1-SNAPSHOT.jar /app.jar
ADD ./config.yml /config.yml
RUN chmod 775 /app.jar
EXPOSE 8080
CMD java -jar /app.jar server /config.yml
