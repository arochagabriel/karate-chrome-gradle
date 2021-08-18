FROM gradle:6.7.0-jdk11
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    xterm \
    fluxbox \
    wmctrl \
    supervisor \
    socat \
    ffmpeg \
    locales \
    locales-all \
    gnupg2 \
  && rm -rf /var/lib/apt/lists/*


RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install --yes \
    google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

RUN useradd chrome --shell /bin/bash --create-home \
  && usermod -a -G sudo chrome \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'chrome:karate' | chpasswd

ENV LANG en_US.UTF-8
RUN apt-get clean \
  && rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/* \
  && mkdir ~/.vnc \
  && x11vnc -storepasswd karate ~/.vnc/passwd \
  && locale-gen ${LANG} \
  && dpkg-reconfigure --frontend noninteractive locales \
  && update-locale LANG=${LANG}
COPY . /tests
CMD ["supervisord", "-n", "-c", "/tests/supervisord.conf"]
