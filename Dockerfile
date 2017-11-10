FROM ubuntu:xenial

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y \
        curl \
        wget \
        software-properties-common;

RUN apt-get install -y \
        build-essential \
        python \
        nodejs \
        xvfb;

RUN wget -q -O - https://deb.nodesource.com/setup_8.x | bash -; \
        apt-get update && apt-get install -y nodejs && \
        npm install npm@latest -g;

RUN wget https://github.com/bep/s3deploy/releases/download/v1.1/s3deploy_1.1_Linux-64bit.deb; \
        dpkg -i s3deploy_1.1_Linux-64bit.deb; \
        rm s3deploy_1.1_Linux-64bit.deb;

RUN node -v; \
    npm -v;

RUN npm install -g bower; \
    npm install -g phantomjs-prebuilt --upgrade --unsafe-perm;

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list; \
    apt-get update; \
    apt-get install -y \
        google-chrome-stable \
        firefox;

RUN alias git=hub

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
