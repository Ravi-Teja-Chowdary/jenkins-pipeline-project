FROM tomcat:10.0.8
LABEL maintainer="ravitejachowdaryparupalli@gmail.com"
ADD ROOT*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
