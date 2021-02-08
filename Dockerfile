


FROM openjdk:8-alpine

ARG POMVERSION

LABEL Maintainer Saiprasanth981

COPY target/pwa-${POMVERSION}.jar /usr/app/

WORKDIR /usr/app/


EXPOSE 8081


ENTRYPOINT ["java", "-jar", "pwa-${POMVERSION}.jar"]
