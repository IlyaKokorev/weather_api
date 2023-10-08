FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

RUN gem install bundler

COPY Gemfile* /app/

RUN bundle install

COPY . /app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
