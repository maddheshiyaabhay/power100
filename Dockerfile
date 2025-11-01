# ---------- Stage 1: Build WAR with Maven ----------
FROM maven:3.8.6-eclipse-temurin-17 AS build

WORKDIR /build

# copy pom first to leverage Docker cache for dependencies
COPY pom.xml .

# copy source
COPY src ./src

# build WAR (skip tests to speed up)
RUN mvn -DskipTests clean package

# ---------- Stage 2: Run on Tomcat ----------
FROM tomcat:9.0-jdk11

# remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# copy built war from build stage -> deploy as ROOT.war
COPY --from=build /build/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh","run"]