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
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
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
    pkg-mozilla-archive-keyring

RUN echo 'deb http://security.debian.org/ stretch/updates main' >> /etc/apt/sources.list.d/stretch-updates.list

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    firefox-esr

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

ENV FIREFOX_BIN /usr/bin/firefox
