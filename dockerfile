# Purpose: Dockerfile used for Torrent Client Build
# Created By: Komquest
# Creation Date: 4/30/2022

# Use linuxserver.io as base image (https://hub.docker.com/r/linuxserver/qbittorrent)

FROM linuxserver/qbittorrent

# Note: for env SSH_USER and env SSH_SERVER, I don't really need this but they are good for SA in container ENV
# Used to specify the Username of the ssh user
ARG ssh_user
ENV SSH_USER=$ssh_user

# Used to specify the IP address of the ssh server
ARG ssh_server
ENV SSH_SERVER=$ssh_server

# Used to specify which port ssh will used to connect
ARG ssh_port
ENV SSH_PORT=$ssh_port

# Used to spcify the listening port that qbittorrent will listen on
ARG listen_port
ENV WEBUI_PORT=$listen_port

# Used to specify the SOCKS Listen Port
ARG socks_port
ENV SOCKS_PORT=$socks_port

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
# Note: I use options to disable host key checking, technically insecure but I don't need a verification prompt
# to stop my automation
# Note 2: I make the socks listen on all interfaces so that one can connect to the SOCKS5 (via a browser or other app)

RUN echo "#!/usr/bin/with-contenv bash" > /etc/cont-init.d/98-ssh-connect
RUN echo "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -f -N -D 0.0.0.0:${socks_port} -i /root/.ssh/${image_name} ${ssh_user}@${ssh_server}" >> /etc/cont-init.d/98-ssh-connect

# Copy of QBittorrent Config File, this should already be built and ready to go
COPY ./qBittorrent.conf /config/

# TODO: healthcheck


