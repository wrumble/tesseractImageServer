FROM tesseractshadow/tesseract4re

RUN apt-get update && apt-get install -y \
        build-essential \
        ruby-full \
        libffi-dev \
        libgmp3-dev \
        ruby-dev

WORKDIR /home/work
COPY . /home/work

RUN cd ImageMagick-7.0.7-8
RUN . configure
RUN make
RUN make install
RUN ldconfig /usr/local/lib

RUN gem install bundler

COPY Gemfile .

RUN bundle install


ENV PATH /home/work/:$PATH

EXPOSE 8080

CMD bundle exec ruby app.rb
