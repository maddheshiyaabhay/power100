# Stage 1: Build with Maven
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package

# Stage 2: Run
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.war ./app.war
EXPOSE 8080
ENV PORT=8080
ENTRYPOINT ["sh","-c","java -Dserver.port=$PORT -jar /app/app.war"]