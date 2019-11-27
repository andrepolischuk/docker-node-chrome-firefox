FROM debian:stretch

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    curl \
    wget \
    gnupg \
    procps \
  && rm -rf /var/lib/apt/lists/*

# Install Node

RUN set -x \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get update \
  && apt-get install -y \
    nodejs \
  && npm install -g npm@latest yarn@latest

RUN set -x \
  && touch ~/.bashrc \
  && echo 'alias nodejs=node' > ~/.bashrc

# Install Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    google-chrome-stable

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome

# Install firefox

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    bzip2 \
    libdbus-glib-1-2

RUN wget -q -O - "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64" | tar xjv -C /opt/
RUN ln -s /opt/firefox/firefox /usr/bin/firefox-stable

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

ENV FIREFOX_BIN /usr/bin/firefox

# Install aws

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    python-pip \
    python-setuptools \
    python-wheel \
    libpython-dev \
  && pip install --upgrade awscli
