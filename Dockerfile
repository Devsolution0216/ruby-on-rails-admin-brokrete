FROM ruby:2.6.0

RUN apt-get update && apt-get install -y nodejs

WORKDIR /tmp
ADD Gemfile* ./

RUN bundle install --jobs=20

ENV APP_HOME /app
COPY . $APP_HOME
WORKDIR $APP_HOME

ENV RAILS_ENV=production \
    RACK_ENV=production \
    PORT=3001

EXPOSE $PORT
