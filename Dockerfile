FROM openjdk:11
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY /build/libs/demo-0.0.1-SNAPSHOT.jar jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
