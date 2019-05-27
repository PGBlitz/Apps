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

initial () {
  rm -rf /pg/var/pgbox.output 1>/dev/null 2>&1
  rm -rf /pg/var/pgbox.buildup 1>/dev/null 2>&1
  rm -rf /pg/var/program.temp 1>/dev/null 2>&1
  rm -rf /pg/var/app.list 1>/dev/null 2>&1
  touch /pg/var/pgbox.output
  touch /pg/var/program.temp
  touch /pg/var/app.list
  touch /pg/var/pgbox.buildup

  bash /pg/coreapps/apps/_appsgen.sh
  docker ps | awk '{print $NF}' | tail -n +2 > /pg/var/pgbox.running
}

queued () {
echo
read -p '⛔️ ERROR - APP Already Queued! | Press [ENTER] ' typed < /dev/tty
question1
}

exists () {
echo ""
echo "⛔️ ERROR - APP Already Installed!"
read -p '⚠️  Do You Want To ReInstall ~ y or n | Press [ENTER] ' foo < /dev/tty

if [ "$foo" == "y" ]; then part1;
elif [ "$foo" == "n" ]; then question1;
else exists; fi
}

cronexe () {
croncheck=$(cat /pg/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /pg/pgblitz/menu/cron/cron.sh; fi
}

cronmass () {
croncheck=$(cat /pg/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /pg/pgblitz/menu/cron/cron.sh; fi
}
