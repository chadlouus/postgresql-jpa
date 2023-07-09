FROM maven:3.8.3-jdk-8-slim

ENV SPRING_PROFILE="cloud,stage"

# The JAR file has a default value in case the user does not pass in a JAR_FILE
ARG JAVA_FILE="*.war"
RUN echo "Jar file: ${JAVA_FILE}"

# The path to copy from must be relative to the root of the project
COPY "target/*.jar" "/app.jar"

# Create cert folder for .pfx files
COPY ./src/main/resources/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

EXPOSE 8080
ENTRYPOINT ["java","-Dspring.profiles.active=${SPRING_PROFILE}","-jar","app.jar"]