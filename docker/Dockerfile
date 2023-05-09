FROM ruby:3.2.2-alpine
RUN apk add --no-cache build-base tzdata nodejs yarn sqlite-dev libpq-dev
RUN crond
WORKDIR /app
COPY web .
RUN gem install bundler
ENV RAILS_ENV=production
RUN bundle install
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
