# Stage 1: Build the application with Maven
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the WAR produced
FROM eclipse-temurin:17-jdk
WORKDIR /app
# copy the war produced by Maven (match any name)
COPY --from=build /app/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]