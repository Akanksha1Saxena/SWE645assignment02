FROM tomcat:9.0-jdk15


COPY target/Studentsurvey.war /usr/local/tomcat/webapps/Studentsurvey.war


