FROM maven:3.6.3-openjdk-11 AS build
WORKDIR /app
COPY . .
COPY settings.xml /usr/share/maven/conf/settings.xml
RUN mvn clean install

FROM tomcat:9-jre11
WORKDIR /usr/local/tomcat/webapps
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 5060
RUN sed -i 's/port="8080"/port="5060"/' /usr/local/tomcat/conf/server.xml
CMD ["catalina.sh", "run"]
