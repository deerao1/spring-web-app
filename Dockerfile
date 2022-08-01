FROM openjdk:11-jre-slim-buster

COPY ./target/testing-web-complete-*.jar /app/myapp.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]

# docker build -t myrepo/myapp:0.0.2 --build-arg ver=0.0.2 .