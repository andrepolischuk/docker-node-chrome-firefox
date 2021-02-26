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
    ssh \
    rsync \
  && rm -rf /var/lib/apt/lists/*

# Install Node

RUN set -x \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs \
  && npm install -g npm@latest

RUN set -x \
  && touch ~/.bashrc \
  && echo 'alias nodejs=node' > ~/.bashrc

RUN set -x \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y yarn

# Install Chrome

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    libxss1 \
    google-chrome-stable

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome

# Install Firefox

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    xvfb \
    bzip2 \
    libdbus-glib-1-2

RUN wget -q -O - "https://download.mozilla.org/?product=firefox-60.0-ssl&os=linux64" | tar xjv -C /opt/
RUN ln -s /opt/firefox/firefox /usr/bin/firefox-stable

ADD scripts/xvfb-firefox /usr/bin/xvfb-firefox
RUN ln -sf /usr/bin/xvfb-firefox /usr/bin/firefox

ENV FIREFOX_BIN /usr/bin/firefox

# Install AWS cli

RUN set -x \
  && apt-get update \
  && apt-get install -y \
    python-pip \
    python-setuptools \
    python-wheel \
    libpython-dev \
  && pip install --upgrade awscli
