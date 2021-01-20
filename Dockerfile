FROM openjdk:8


RUN apt-get -y install git


WORKDIR /js
RUN git clone https://github.com/docker-hy/spring-example-project
WORKDIR /js/spring-example-project

RUN ./mvnw package

EXPOSE 8080

ENTRYPOINT ["java","-jar"]
CMD ["./target/docker-example-1.1.3.jar"]