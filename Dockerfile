# syntax=docker/dockerfile:1
FROM ruby:3.2.1
# RUN apt-get update -qq && apt-get install -y imagemagick ffmpeg
RUN apt-get update -qq && apt-get install -y build-essential
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
