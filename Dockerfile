# Docker Build Stage
FROM maven


# Build Stage
WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk

COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 8081
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","app.jar"]

