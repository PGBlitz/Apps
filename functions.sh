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
################################################################################
appgen () {

### Blank Out Temp List
rm -rf /pg/var/program.temp && touch /pg/var/program.temp

### List Out Apps In Readable Order (One's Not Installed)
sed -i -e "/templates/d" /pg/var/app.list
touch /pg/tmp/test.99
num=0
while read p; do
  echo -n $p >> /pg/var/program.temp
  echo -n " " >> /pg/var/program.temp
  num=$[num+1]
  if [ "$num" == 7 ]; then
    num=0
    echo " " >> /pg/var/program.temp
  fi
done </pg/var/app.list

notrun=$(cat /pg/var/program.temp)
buildup=$(cat /pg/var/pgbox.output)

if [ "$buildup" == "" ]; then buildup="NONE"; fi
}
################################################################################
userlistgen () {
echo "$typed" >> /pg/var/pgbox.buildup
num=0

touch /pg/var/pgbox.output && rm -rf /pg/var/pgbox.output

while read p; do
echo -n $p >> /pg/var/pgbox.output
echo -n " " >> /pg/var/pgbox.output
if [ "$num" == 7 ]; then
  num=0
  echo " " >> /pg/var/pgbox.output
fi
done </pg/var/pgbox.buildup

sed -i "/^$typed\b/Id" /pg/var/app.list

question1
}
################################################################################
cronexe () {
croncheck=$(cat /pg/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /pg/apps/cron/cron.sh; fi
}

cronmass () {
croncheck=$(cat /pg/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /pg/apps/cron/cron.sh; fi
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

  # from _appsgen.sh (generates the list of apps to install)
  appslistgen

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

final () {
  read -p '✅ Process Complete! | PRESS [ENTER] ' typed < /dev/tty
  echo
  exit
}
