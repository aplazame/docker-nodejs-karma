FROM ubuntu:trusty

MAINTAINER Jesús Germade <jesus@aplazame.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y build-essential; \
    apt-get install -y git curl python; \
    curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -; \
    apt-get update && apt-get install -y chromium-browser nodejs Xvfb; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    npm install npm -g; \
    npm install bower -g; \
    npm install phantomjs-prebuilt -g

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/chromium-browser

ENTRYPOINT ["/entrypoint.sh"]
