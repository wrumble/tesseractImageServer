
FROM tesseractshadow/tesseract4re

RUN apt-get update && apt-get install -y \
        build-essential \
        ruby-full \
        libgs-dev \
        libffi-dev \
        libgmp3-dev \
        ruby-dev \
        imagemagick \
        bc \
        gawk

WORKDIR /home/work

RUN gem install bundler

COPY Gemfile .

RUN bundle install

COPY . /home/work
ENV PATH /home/work/:$PATH

EXPOSE 8080

CMD bundle exec ruby app.rb
