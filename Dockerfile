FROM tomcat:8.0-apline
LABEL maintainer="ravitejachowdaryparupalli@gmail.com"
ADD ROOT*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
