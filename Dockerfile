FROM ruby:3.2.2

RUN apt-get update && apt-get install -y build-essential libpq-dev

RUN apt-get install -y curl software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

EXPOSE 3000

ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./

RUN --mount=type=ssh \
  bundle install -j 8

COPY . ./

RUN echo 'IRB.conf[:USE_AUTOCOMPLETE] = false' >> ~/.irbrc

CMD ["bin/start_process.sh"]

