

ARG POMVERSION

FROM openjdk:8-alpine

ARG POMVERSION

LABEL Maintainer Saiprasanth981

COPY ./target/pwa-"${POMVERSION}".jar /usr/app/

WORKDIR /usr/app/

RUN echo "#!/bin/bash \n java -jar /usr/app/pwa-${POMVERSION}.jar" > ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

EXPOSE 8081


ENTRYPOINT ["sh", "entrypoint.sh"]
