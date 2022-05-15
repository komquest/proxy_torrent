# Created By: Komquest
# Creation Date: 4/30/2022
# Purpose: Dockerfile used for Torrent Client Build

# Use linuxserver.io as base image (https://hub.docker.com/r/linuxserver/qbittorrent)

# Build like this: docker build ./ -t test_qbittorrent --build-arg ssh_pub_key="Hello World"

# ssh -f -N -D [bind_address:]$port_number -i RSA $username@$hostname

# 1. Generate ssh keypair, copy over RSA/Save Public
FROM linuxserver/qbittorrent

# Used to specify the Username of the ssh user (Might need to move this to build script) (or make these env)
ARG ssh_user
ENV SSH_USER=$ssh_user

# Used to specify the IP address of the ssh server (Might need to move this to build script) (or make these env)
ARG ssh_server
ENV SSH_SERVER=$ssh_server

# Used to spcify the listening port that qbittorrent will listen on
ARG listen_port
ENV WEBUI_PORT=$listen_port

# Used to specify the image name so ssh keys can be copied correctly
ARG image_name

# Install ssh
RUN apk add openrc openssh

# Create ssh dir in root folder
RUN mkdir /root/.ssh && chmod 700 /root/.ssh

# Copy over created Private Key 
COPY ./${image_name} /root/.ssh/

# Create a script that runs upon container startup. I got the information on startup locations from:
# https://github.com/linuxserver/docker-mods
# The bind Address and Port are hard coded as shown , did not find a use case that supported modification
# Note: I use options to disable host key checking, technically insecure but I don't need a verification prompt
# to stop my automation

RUN echo "#!/usr/bin/with-contenv bash" > /etc/cont-init.d/98-ssh-connect
RUN echo "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -f -N -D 127.0.0.1:2222 -i /root/.ssh/${image_name} ${ssh_user}@${ssh_server}" >> /etc/cont-init.d/98-ssh-connect

# Copy of QBittorrent Config File

# Do a healthcheck???


