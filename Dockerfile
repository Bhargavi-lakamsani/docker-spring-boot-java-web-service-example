FROM openjdk:8-jre-alpine
RUN apk update && apk add bash
WORKDIR /app
COPY target/*.jar /app/
EXPOSE 8080
CMD ["java", "-jar", "docker-java-app-example.jar"]
