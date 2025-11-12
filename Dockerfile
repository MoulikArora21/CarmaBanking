# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies first (better layer caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B || mvn dependency:resolve -B || mvn dependency:resolve-plugins -B

# Copy source code and build
COPY src ./src
RUN mvn clean install -DskipTests -B -e

# Run stage - using JDK (not JRE) for JSP support
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]