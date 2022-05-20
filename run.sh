#! /bin/bash
# Purpose: This will run the previously built docker image.
# Script args as follows: $1 = Previously built Image Name, $2 = What the Container Name Should be, $3 = qbittorent listen port (this will 
# open same port on host) $4 = SOCKSPORT, used to conenct a web browser or other app to socks5 $5 = Path used to store local torrent downloads on host
# Created By: Komquest
# Created On: 5/15/2022


DATE=$(date -u +%Y%m%d-%H.%M.%S)
LOG="/tmp/server.log"

# Check to make sure you have input your variables
if [ ! -z "$1" ] && [ ! -z "$2" ] && [ ! -z "$3" ] && [ ! -z "$4" ] && [ ! -z "$5" ]; then


  # Variables
  IMAGENAME="$1"
  CONTAINERNAME="$2"
  LISTENPORT="$3"
  SOCKSPORT="$4"
  DOWNLOADPATH="$5"

  echo "<${DATE}><INFO>_Start Run: ${IMAGENAME}" >> ${LOG} 2>&1

  docker run -d \
  --name=${CONTAINERNAME}\
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p ${LISTENPORT}:${LISTENPORT} \
  -p ${SOCKSPORT}:${SOCKSPORT} \
  -v ${DOWNLOADPATH}:/downloads \
  --restart unless-stopped \
  ${IMAGENAME} \
  >> ${LOG} 2>&1


  if [ $? -ne 0 ]; then
    echo "<${DATE}><ERROR>_Please Verify Config" >> ${LOG} 2>&1
    exit 1
  else
    echo "<${DATE}><INFO>_Running, Please check ${CONTAINERNAME} for any problems" >> ${LOG} 2>&1
    exit 0
  fi

else

  echo "<${DATE}><ERROR>_Please Specify Correct Arguments" >> ${LOG} 2>&1
  echo "<${DATE}><ERROR>_Please Specify Correct Arguments"
  echo "<${DATE}><Info>_run.sh IMAGENAME CONTAINERNAME LISTENPORT SOCKSPORT DOWNLOADPATH"

fi

