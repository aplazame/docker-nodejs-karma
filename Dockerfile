FROM ubuntu:trusty

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update; \
    apt-get install -y \
        curl \
        wget \
        software-properties-common; \
    add-apt-repository ppa:cpick/hub; \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -; \
    echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list; \
    wget -q -O - https://deb.nodesource.com/setup_12.x | bash -; \
    apt-get install -y --force-yes \
        build-essential \
        python \
        hub \
        google-chrome-stable \
        firefox \
        nodejs \
        unzip \
        jq \
        gettext-base \
        Xvfb; \
    curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
    unzip -qq /tmp/awscliv2.zip -d /tmp/ && \
    chmod +x /tmp/aws/install && \
    sudo /tmp/aws/install;

RUN alias git=hub

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome

RUN npm install -g npm
RUN npm install -g \
        bower \
        phantomjs-prebuilt

ADD xvfb.sh /etc/init.d/xvfb
ADD entrypoint.sh /entrypoint.sh

COPY bin/ /opt/bin
ENV PATH="/opt/bin:${PATH}"

RUN mkdir ~/.aws/

ENTRYPOINT ["/entrypoint.sh"]
