FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /ops-app
RUN git clone https://github.com/abdullasd14301/ops-abdul.git .
RUN mvn clean package
FROM tomcat:10.1-jdk17
WORKDIR /usr/local/tomcat/webapps/
COPY --from=builder /ops-app/target/*.war opskill.war
RUN ls -l /usr/local/tomcat/webapps/
RUN chmod 644 /usr/local/tomcat/webapps/opskill.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
