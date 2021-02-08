FROM openjdk:8-alpine

LABEL Maintainer Saiprasanth981

COPY target/pwa*.jar /usr/app/

WORKDIR /usr/app/


EXPOSE 8081


ENTRYPOINT ["java", "-jar", "pwa*.jar"]
