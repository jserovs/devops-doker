FROM alpine:3
RUN apk update

RUN apk add git
RUN apk add curl
RUN apk add maven
RUN apk add openjdk8


WORKDIR /home/developer/

CMD ["sh"]
