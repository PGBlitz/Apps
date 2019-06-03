#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /pg/apps/functions.sh
source /pg/apps/_appsgen.sh

# Part 1
question1 () {

# Generates the List of Apps to Install
appgen

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PGBox ~ Multi-App Installer  ~ 📓 Visit: pgbox.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂 Potential Apps to Install
$notrun

💾 Apps Queued for Installation
$buildup

💬 Quitting? TYPE > exit  |  💪 Ready to install? TYPE > deploy
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '🌍 Type APP for QUEUE | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "deploy" ]; then question2; fi

if [ "$typed" == "exit" ]; then exit; fi

current=$(cat /pg/var/pgbox.buildup | grep "\<$typed\>")
if [ "$current" != "" ]; then queued && question1; fi

current=$(cat /pg/var/pgbox.running | grep "\<$typed\>")
if [ "$current" != "" ]; then exists && question1; fi

current=$(cat /pg/var/program.temp | grep "\<$typed\>")
if [ "$current" == "" ]; then badinput1 && question1; fi

userlistgen
}

question2 () {

# Image Selector
image=off
while read p; do

echo $p > /pg/tmp/program_var

bash /pg/apps/apps/image/_image.sh
done </pg/var/pgbox.buildup

while read p; do
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$p - Now Installing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

sleep 1

if [ "$p" == "plex" ]; then bash /pg/apps/plex/plex.sh;
elif [ "$p" == "nzbthrottle" ]; then nzbt; fi

# Execute Main Program
apps="${p}"
echo $apps > /pg/var/role.name
bash "/pg/apps/apps/${p}/start.sh"

# End Banner
bash /pg/apps/additional/endbanner.sh >> /pg/tmp/output.info

sleep 2
done </pg/var/pgbox.buildup
echo "" >> /pg/tmp/output.info
cat /pg/tmp/output.info
final
}

# FUNCTIONS END ##############################################################
echo "" > /pg/tmp/output.info

initial
question1
