FROM openjdk:8-jdk-alpine
RUN apk update ;\
apk add --no-cache curl curl git maven

WORKDIR /usr/local/jetty/
RUN curl -L "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.39.v20210325/jetty-distribution-9.4.39.v20210325.tar.gz" -o jetty.tar.gz ;\
tar  -xvf jetty.tar.gz ;\
cp -R jetty-distribution-9.4.39.v20210325/* . ;\
rm -R jetty-distribution-9.4.39.v20210325/    ;\
rm -R /usr/local/jetty/demo-base/webapps/* ;\
rm  jetty.tar.gz

WORKDIR /tmp/hello/

RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git ./ ;\
mvn package ;\
cp ./target/hello-1.0.war /usr/local/jetty/demo-base/webapps ;\
rm -R /tmp/hello/

RUN apk del curl git maven

WORKDIR /usr/local/jetty/demo-base/
EXPOSE 8080
CMD java -jar /usr/local/jetty/start.jar
