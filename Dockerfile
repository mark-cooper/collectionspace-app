FROM ruby:2.2.0

RUN apt-get update -qq && apt-get -y install \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  nodejs

RUN git clone https://github.com/lyrasis/collectionspace-app.git /app
WORKDIR /app

RUN gem install bundler && bundle install --without development test

RUN bundle exec rake assets:precompile

# see documentation for COLLECTIONSPACE environment requirements
ENV MAX_THREADS=5 \
  PORT=3000 \
  RACK_ENV=production \
  RAILS_SERVE_STATIC_FILES=true \
  RAILS_ENV=production \
  WEB_CONCURRENCY=2

CMD bundle exec puma -C config/puma.rb