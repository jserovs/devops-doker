FROM ruby:2.6.0


RUN apt-get -y install git

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt install -y nodejs


WORKDIR /js
RUN git clone https://github.com/docker-hy/rails-example-project
WORKDIR /js/rails-example-project

RUN rm -frv /js/rails-example-project/config/credentials.yml.enc

RUN bundle install
ENV RAILS_LOG_TO_STDOUT=true

# dev version
# RUN rails db:migrate
# ENTRYPOINT ["rails","s"]

RUN EDITOR="mate --wait" bin/rails credentials:edit
RUN rails db:migrate RAILS_ENV=production

RUN rake assets:precompile

EXPOSE 3000



ENTRYPOINT ["rails","s", "-e"]
CMD ["production"]

