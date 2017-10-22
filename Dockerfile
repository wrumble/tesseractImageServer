FROM tesseractshadow/tesseract4re

RUN apt-get update && apt-get install -y \
        build-essential \
        ruby-full \
        libffi-dev \
        libgmp3-dev \
        ruby-dev \
        fftw-dev \
        libjpeg62-dev \
        libjpeg8-dev \
        libfftw3-3 \
        libfftw3-dev

RUN apt-get source imagemagick

WORKDIR /home/work

RUN gem install bundler

COPY Gemfile .

RUN bundle install

COPY . /home/work
ENV PATH /home/work/:$PATH

EXPOSE 8080

CMD bundle exec ruby app.rb
