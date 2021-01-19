FROM ubuntu:16.04

RUN apt-get update; apt-get -y install curl
RUN apt-get -y install git
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt install -y nodejs

RUN node -v && npm -v


WORKDIR /js
RUN git clone https://github.com/docker-hy/frontend-example-docker
WORKDIR /js/frontend-example-docker

RUN npm install
EXPOSE 5000

ENTRYPOINT ["npm"]
CMD ["start"]