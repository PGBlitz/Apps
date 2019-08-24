#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mkdir -p /pg/var/emergency
mkdir -p /pg/data/blitz
rm -rf /pg/var/emergency/*
sleep 15
diskspace27=0

while true
do

# GDrive
if [[ $(rclone lsd --config /pg/rclone/blitz.conf gd: | grep "\<plexguide\>") == "" ]]; then
  echo "🔴 Not Operational "> /pg/var/pg.gd; else echo "✅ Operational " > /pg/var/pg.gd; fi

if [[ $(ls -la /pg/gd | grep "plexguide") == "" ]]; then
  echo "🔴 Not Operational"> /pg/var/pg.gmount; else echo "✅ Operational" > /pg/var/pg.gmount; fi

# SDrive
if [[ $(rclone lsd --config /pg/rclone/blitz.conf sd: | grep "\<plexguide\>") == "" ]]; then
  echo "🔴 Not Operational"> /pg/var/pg.sd; else echo "✅ Operational" > /pg/var/pg.sd; fi

if [[ $(ls -la /pg/sd | grep "plexguide") == "" ]]; then
  echo "🔴 Not Operational "> /pg/var/pg.smount; else echo "✅ Operational" > /pg/var/pg.smount; fi

# Union
if [[ $(rclone lsd --config /pg/rclone/blitz.conf pgunity: | grep "\<plexguide\>") == "" ]]; then
  echo "🔴 Not Operational "> /pg/var/pg.union; else echo "✅ Operational" > /pg/var/pg.union; fi

if [[ $(ls -la /pg/unity | grep "plexguide") == "" ]]; then
  echo "🔴 Not Operational "> /pg/var/pg.umount; else echo "✅ Operational " > /pg/var/pg.umount; fi

# Disk Calculations - 4000000 = 4GB

leftover=$(df /pg/data/blitz | tail -n +2 | awk '{print $4}')


if [[ "$leftover" -lt "3000000" ]]; then
  diskspace27=1
  echo "Emergency: Primary DiskSpace Under 3GB - Stopped Media Programs & Downloading Programs (i.e. Plex, NZBGET, RuTorrent)" > /pg/var/emergency/message.1
  docker stop plex 1>/dev/null 2>&1
  docker stop emby 1>/dev/null 2>&1
  docker stop jellyfin 1>/dev/null 2>&1
  docker stop nzbget 1>/dev/null 2>&1
  docker stop sabnzbd 1>/dev/null 2>&1
  docker stop rutorrent 1>/dev/null 2>&1
  docker stop deluge 1>/dev/null 2>&1
  docker stop qbitorrent 1>/dev/null 2>&1
elif [[ "$leftover" -gt "3000000" && "$diskspace27" == "1" ]]; then
  docker start plex 1>/dev/null 2>&1
  docker start emby 1>/dev/null 2>&1
  docker start jellyfin 1>/dev/null 2>&1
  docker start nzbget 1>/dev/null 2>&1
  docker start sabnzbd 1>/dev/null 2>&1
  docker start rutorrent 1>/dev/null 2>&1
  docker start deluge 1>/dev/null 2>&1
  docker start qbitorrent 1>/dev/null 2>&1
  rm -rf /pg/var/emergency/message.1
  diskspace27=0
fi

##### Warning for Ports Open with Traefik Deployed
if [[ $(cat /pg/var/pg.ports) != "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "traefik" ]]; then
  echo "Warning: Traefik deployed with ports open! Server at risk for explotation!" > /pg/var/emergency/message.a
elif [ -e "/pg/var/emergency/message.a" ]; then rm -rf /pg/var/emergency/message.a; fi

if [[ $(cat /pg/var/pg.ports) == "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "" ]]; then
  echo "Warning: Apps Cannot Be Accessed! Ports are Closed & Traefik is not enabled!"
  echo "Either deploy traefik or open your ports (which is worst for security)" > /pg/var/emergency/message.b
elif [ -e "/pg/var/emergency/message.b" ]; then rm -rf /pg/var/emergency/message.b; fi
##### Warning for Bad Traefik Deployment - message.c is tied to traefik showing a status! Do not change unless you know what your doing
touch /pg/var/traefik.check
domain=$(cat /pg/var/server.domain)
wget -q "https://portainer.${domain}" -O "/pg/var/traefik.check"
if [[ $(cat /pg/var/traefik.check) == "" && $(docker ps --format '{{.Names}}' | grep traefik) == "traefik" ]]; then
  echo "Traefik is Not Deployed Properly! Cannot Reach the Portainer SubDomain!" > /pg/var/emergency/message.c
else
  if [ -e "/pg/var/emergency/message.c" ]; then
  rm -rf /pg/var/emergency/message.c; fi
fi
##### Warning for Traefik Rate Limit Exceeded
if [[ $(cat /pg/var/traefik.check) == "" && $(docker logs traefik | grep "rateLimited") != "" ]]; then
  echo "$domain's rated limited exceed | Traefik (LetsEncrypt)! Takes upto one week to"
  echo "clear up (or use a new domain)" > /pg/var/emergency/message.d
else
  if [ -e "/pg/var/emergency/message.d" ]; then
  rm -rf /pg/var/emergency/message.d; fi
fi

################# Generate Output
echo "" > /pg/var/emergency.log

if [[ $(ls /pg/var/emergency) != "" ]]; then
countmessage=0
while read p; do
  let countmessage++
  echo -n "${countmessage}. " >> /pg/var/emergency.log
  echo "$(cat /pg/var/emergency/$p)" >> /pg/var/emergency.log
done <<< "$(ls /pg/var/emergency)"
else
  echo "NONE" > /pg/var/emergency.log
fi

sleep 5
done
