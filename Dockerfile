FROM aplazame/nodejs-karma:0.7.4

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get install -y --force-yes \
        unzip \
        jq \
        gettext-base; \
    curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
    unzip -qq /tmp/awscliv2.zip -d /tmp/ && \
    chmod +x /tmp/aws/install && \
    /tmp/aws/install;

COPY bin/ /opt/bin
ENV PATH="/opt/bin:${PATH}"

RUN mkdir ~/.aws/
