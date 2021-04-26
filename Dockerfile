FROM openjdk:8-jdk-alpine
MAINTAINER john <john.kolahdouzan@gmail.com>
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
CMD ["echo", "Dockerfile last line"]