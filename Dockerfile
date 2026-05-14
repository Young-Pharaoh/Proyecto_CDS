# Stage 1: Build
FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY . .

# Patch hardcoded localhost → Docker service name, and align passwords
RUN sed -i 's|localhost:3306|db:3306|g' \
        src/main/resources/META-INF/persistence.xml && \
    sed -i 's/"localhost:3306"/"db:3306"/g' \
        src/main/java/modelo/conexion/BddConnection.java && \
    sed -i 's/String password = "";/String password = "dbadmin";/' \
        src/main/java/modelo/conexion/BddConnection.java

RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM tomcat:10.1-jdk21-temurin-alpine
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
