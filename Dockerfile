FROM gradle:6.9.2-jdk11 AS build

COPY --chown=gradle:gradle . /home/gradle/src

WORKDIR /home/gradle/src

RUN gradle build --no-daemon --exclude-task test

FROM openjdk:11-jre

COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar

WORKDIR /app

CMD ["java" , "-jar", "app.jar"]