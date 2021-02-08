FROM openjdk:8-alpine

LABEL Maintainer Saiprasanth981

COPY demo-0.0.1-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app/


EXPOSE 8082


#ENTRYPOINT ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
