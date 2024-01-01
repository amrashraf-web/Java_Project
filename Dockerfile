FROM tomcat:9-jre11
WORKDIR /usr/local/tomcat/webapps
COPY /publish-artifacts/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 5060
RUN sed -i 's/port="8080"/port="5060"/' /usr/local/tomcat/conf/server.xml
CMD ["catalina.sh", "run"]
