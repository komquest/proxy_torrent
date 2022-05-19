#! /bin/bash
# Purpose: This will build the torrent server image. It will create ssh keypair, set username/ip (ssh server) and port (listen port) 
# and then build using dockerfile. Script args as follows: $1 = username, $2 = ssh server ip, $3 = qbittorent listen port, $4 = ImageName
# Created By: Komquest
# Created On: 5/15/2022


DATE=$(date -u +%Y%m%d-%H.%M.%S)
LOG="/tmp/server.log"

# Check to make sure you have input your variables
if [ ! -z "$1" ] && [ ! -z "$2" ] && [ ! -z "$3" ] && [ ! -z "$4" ] && [ ! -z "$5" ]; then


  # Variables
  USERNAME="$1"
  SSHSERVER="$2"
  LISTENPORT="$3"
  SOCKSPORT="$4"
  IMAGENAME="$5"


  echo "<${DATE}><INFO>_Start Build ${IMAGENAME}" >> ${LOG} 2>&1

  # Create ssh keypair, no passphrase, no Comment

  ssh-keygen -t rsa -b 4096 -f "./${IMAGENAME}" -q -N '' -C '' >> ${LOG} 2>&1

  # Build Image Using DockerFile

  docker build ./ -t $IMAGENAME  \
  --build-arg ssh_user="${USERNAME}" \
  --build-arg ssh_server="${SSHSERVER}" \
  --build-arg listen_port="${LISTENPORT}" \
  --build-arg socks_port="${SOCKSPORT}" \
  --build-arg image_name="${IMAGENAME}" \
  >> ${LOG} 2>&1


  if [ $? -ne 0 ]; then
    echo "<${DATE}><ERROR>_Please Verify Config" >> ${LOG} 2>&1
    exit 1
  else
    echo "<${DATE}><INFO>_Built, Please copy ssh public key to remote ssh socks server (${SSHSERVER})" >> ${LOG} 2>&1
    echo "<${DATE}><INFO>_Built, Please copy ssh public key to remote ssh socks server (${SSHSERVER})"
    exit 0
  fi

else

  echo "<${DATE}><ERROR>_Please Specify Correct Arguments" >> ${LOG} 2>&1
  echo "<${DATE}><ERROR>_Please Specify Correct Arguments"
  echo "<${DATE}><Info>_build.sh USERNAME SSHSERVER LISTENPORT SOCKSPORT IMAGENAME"

fi