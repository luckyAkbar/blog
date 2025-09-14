FROM ruby:3.2.3-alpine AS builder

RUN apk add --no-cache --update build-base git
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && \
    bundle install

COPY . .
RUN JEKYLL_ENV=production bundle exec jekyll build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/_site /usr/share/nginx/html
EXPOSE 80