FROM alpine:3.7

RUN apk add --no-cache \
  build-base \
  automake \
  linux-headers \
  ruby-bundler \
  ruby-dev \
  ruby-json \
  ruby-bigdecimal \
  postgresql-dev \
  libffi-dev \
  libxml2-dev \
  curl-dev \
  imagemagick \
  nodejs \
  tzdata \
  postgresql-client
RUN rm -rf /var/cache/apk/*
RUN mkdir /app
COPY Gemfile /app
COPY Gemfile.lock /app
WORKDIR /app
RUN bundle install -j4
COPY . /app
RUN mv config/database.yml.example config/database.yml
RUN mv config/local_config.rb.example config/local_config.rb
RUN rake assets:precompile
EXPOSE 3000
