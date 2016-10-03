FROM ubuntu:16.04

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

# RUN apt-get update && \
#   DEBIAN_FRONTEND=noninteractive apt-get install -y \
#     build-essential \
#     git \
#     golang \
#     libgmp3-dev \
#     inetutils-ping \
#     dnsutils
#
# WORKDIR /root
# RUN mkdir ur_data
#
# # RUN git clone https://github.com/ur-technology/go-ur.git; make -C go-ur gur && cp ./go-ur/build/bin/gur /usr/bin
# ADD ./files/bin/gur /usr/bin/gur
#
# EXPOSE 9595 19595 19595/udp
#
# # TODO: figure out how to build on top of gur-client

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      build-essential \
      curl \
      dnsutils \
      git \
      inetutils-ping && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -y nodejs python

RUN adduser --disabled-password --gecos "" explorer-user && usermod -aG sudo explorer-user
USER explorer-user
WORKDIR /home/explorer-user

RUN git clone https://github.com/ur-technology/explorer.git

EXPOSE 8080
