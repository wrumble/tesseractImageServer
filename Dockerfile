FROM tesseractshadow/tesseract4re

RUN apt-get update && apt-get install -y \
        build-essential \
        ruby-full \
        ruby-dev \
        libffi-dev \
        libgmp3-dev \
        imagemagick

WORKDIR /home/work

RUN gem install bundler

COPY Gemfile .
COPY textdeskew .

RUN bundle install

COPY . /home/work
ENV PATH /home/work/:$PATH

EXPOSE 8080

CMD bundle exec ruby app.rb
