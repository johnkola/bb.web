FROM openjdk:8-jdk-alpine
LABEL maintainer="john.kolahdouzan@gmail.com"
COPY ${JAR_FILE} app.jar
CMD ["echo", '${JAR_FILE}']
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
CMD ["echo", "Dockerfile last line"]