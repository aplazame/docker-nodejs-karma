FROM ubuntu:trusty

MAINTAINER Jesús Germade <jesus@aplazame.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y \
      bison \
      build-essential \
      curl \
      flex \
      g++ \
      git \
      gperf \
      sqlite3 \
      libsqlite3-dev \
      fontconfig \
      libfontconfig1 \
      libfontconfig1-dev \
      libfreetype6 \
      libfreetype6-dev \
      libicu-dev \
      libjpeg-dev \
      libpng-dev \
      libssl-dev \
      libqt5webkit5-dev \
      ruby \
      python \
      perl \
      unzip \
      wget; \

    curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -; \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - ; \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'; \

    apt-get update && apt-get install -y google-chrome-stable nodejs Xvfb; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \

    npm install bower -g; \
    npm install phantomjs -g

RUN mkdir -p /usr/src; \
    cd /usr/src; \
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip; \
    unzip phantomjs-2.0.0-source.zip; \
    rm phantomjs-2.0.0-source.zip; \
    cd phantomjs-2.0.0; \
    ./build.sh --confirm

RUN cp /usr/src/phantomjs-2.0.0/bin/phantomjs /usr/local/bin/phantomjs

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

ENTRYPOINT ["/entrypoint.sh"]
