# Simple SOCKS Torrent Client

## Purpose: This project will utilize docker to build a custom QBittorent Client that will automatically connect to a remote SOCKS Proxy.
---
## Requirements:

1. Docker

## How To:
Clone the Repo and then:

1. Run "Build.sh"

USERNAME --> ssh username

SSHSERVER --> ssh server that hosts the socks proxy

LISTENPORT --> qbittorrent client web console port

SOCKSPORT  --> socks5 ssh foward port (connect a web browser to this)

SSHPORT --> The port used when SSH connects, if you don't want to use default of 22

IMAGENAME --> docker Image Name

```
./build.sh USERNAME SSHSERVER LISTENPORT SOCKSPORT SSHPORT IMAGENAME

./build.sh sshuser 12.34.56.78 1234 4321 3211 server_image
```

2. Run "run.sh"

IMAGENAME  --> Name of image used during build phase

CONTAINERNAME  --> The name of container

LISTENPORT --> docker port mapping, needs to be the same as "LISTENPORT" from build phase

SOCKSPORT  --> docker port mapping, needs to be the same as "SOCKSPORT" from build phase

DOWNLOADPATH --> the local host path you want downloads to be saved to

```
./run.sh IMAGENAME CONTAINERNAME LISTENPORT SOCKSPORT DOWNLOADPATH

./run.sh server_image myserver 1234 4321 /mnt/downloads/
```

3. Access:
- qbittorent web via "LISTENPORT"
- SOCKS5 Proxy via "SOCKSPORT"