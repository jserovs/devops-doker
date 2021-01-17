FROM ubuntu:16.04

RUN apt-get update; apt-get -y install curl

WORKDIR /curler
RUN pwd
RUN touch test_file.test_file
COPY curl-my-website.sh .
# RUN ./dev/curler/curl-my-website.sh
# ENTRYPOINT [ "/dev/curler/curl-my-website.sh" ]
CMD ["./curl-my-website.sh"]