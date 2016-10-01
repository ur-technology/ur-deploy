FROM ubuntu:16.04

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    git \
    golang \
    libgmp3-dev && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN mkdir .ssh ur_data
RUN chmod 700 .ssh
ADD ./id_rsa_ur_capital.pub .ssh/authorized_keys
RUN chmod 600 .ssh/authorized_keys

RUN git clone https://github.com/ur-technology/go-ur.git; make -C go-ur gur # figure out how to build this outside of docker and copy it in

EXPOSE 9595
EXPOSE 19595
EXPOSE 19595/udp


# TODO: figure out how to build on top of gur-client

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -y nodejs python bower

RUN git clone https://github.com/ur-technology/explorer.git && \
  cd explorer && \
  npm install -g bower
  npm install --unsafe-perm && \
  bower install --allow-root; cd

EXPOSE 8000
