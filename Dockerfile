FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
RUN git clone https://github.com/Bhargavi-lakamsani/docker-spring-boot-java-web-service-example.git
WORKDIR /app/docker-spring-boot-java-web-service-example
RUN mvn clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/docker-spring-boot-java-web-service-example/target/*.jar /app/
EXPOSE 8080
CMD ["java", "-jar", "your-application.jar"]

