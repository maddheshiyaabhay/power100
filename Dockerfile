FROM moven:3.8.8-eclipse-temurin-17 AS build WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.war"]
