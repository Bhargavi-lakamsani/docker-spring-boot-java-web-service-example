FROM openjdk:8-jre-alpine as checkout
RUN apk add --no-cache git
WORKDIR /app
RUN git https://github.com/Bhargavi-lakamsani/docker-spring-boot-java-web-service-example.git
RUN mvn clean install
COPY /target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080
