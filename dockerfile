# Created By: Komquest
# Creation Date: 4/30/2022
# Purpose: Dockerfile used for Torrent Client Build

# Use linuxserver.io as base image (https://hub.docker.com/r/linuxserver/qbittorrent)

# Build like this: docker build ./ -t test_qbittorrent
FROM linuxserver/qbittorrent


RUN \
  touch /a.txt \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh

ARG ssh_pub_key

RUN echo "$ssh_pub_key" > /root/.ssh/authorized_keys

RUN apk add openrc openssh
