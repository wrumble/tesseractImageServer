FROM tesseractshadow/tesseract4re

RUN apt-get update && apt-get install -y build-essential ruby-full libffi-dev libgmp3-dev ruby-dev

WORKDIR /home/work

RUN gem install bundler

COPY Gemfile .

RUN bundle install

COPY . /home/work

EXPOSE 8080

CMD bundle exec ruby app.rb
