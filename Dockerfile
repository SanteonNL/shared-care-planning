FROM node:lts-buster as build
WORKDIR /app

RUN apt update &&  apt install -y jekyll graphviz default-jre && apt clean
RUN npm install -y -g fsh-sushi

COPY _updatePublisher.sh /app
RUN /bin/bash _updatePublisher.sh -y -f

COPY ig.ini /app
COPY sushi-config.yaml /app


CMD ["bash", "_genonce.sh"]

