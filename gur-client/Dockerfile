FROM ubuntu:16.04

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    git \
    golang \
    libgmp3-dev \
    inetutils-ping \
    dnsutils

RUN adduser --disabled-password --gecos "" deploy && usermod -aG sudo deploy
USER deploy
WORKDIR /home/deploy

RUN mkdir ur_data
RUN mkdir .ethash

# RUN git clone https://github.com/ur-technology/go-ur.git; make -C go-ur gur && cp ./go-ur/build/bin/gur /usr/bin
ADD ./files/bin/gur /usr/bin/gur

EXPOSE 9595 19595 19595/udp
