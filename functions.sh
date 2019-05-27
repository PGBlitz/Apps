#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
common () {
  mkdir -p "/pg/data/{$apps}"

  if [[ "apps" != "plex" ]]; then
    chown -R 1000:1000 "/pg/data/{$apps}"
    chmod -R 775 "/pg/data/{$apps}"
  else
    chown 1000:1000 "/pg/data/{$apps}"
    chmod 775 "/pg/data/{$apps}"
  fi 

  docker stop ${apps}
  docker rm ${apps}
}
