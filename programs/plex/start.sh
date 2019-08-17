#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# DO NOT CHANGE OR DELETE!
source /pg/apps/functions.sh
apps="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
apps="$( echo "$apps" | cut -d'/' -f5- )"
common
################################################################################
# STARTER CODE! If there is any code to execute before role deployment!
#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty

}

badinput2() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  question1
}

question1() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PG - PLEX Installer ~ http://plex.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE1: Using LOCAL SERVER  - YOUR HOUSE on YOUR NETWORK? Select #1
NOTE2: USING REMOTE SERVER - Hetzner, GCE, NETCUP & ETC? Select #2.
NOTE3: Selecting WRONG OPTION requires, UNINSTALL > then REINSTALL!

[1] Plex Local System
[2] Plex Remote System
[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty
  echo ""
  if [ "$typed" == "2" ]; then
    echo remote >/pg/var/plex.server && question3
  elif [ "$typed" == "1" ]; then
    echo local >/pg/var/plex.server
  elif [[ "$typed" == "z" || "$typed" == "Z" ]]; then
    exit
  else badinput2; fi
}

# THIRD QUESTION
question3() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Remote Plex Server - Claim the Plex Server
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
To Claim the Plex Server, visit https://www.plex.tv/claim/ and input the
code below! You have 5 minutes to do so!

If reinstalling PLEX with a prior setup, this step as you won't need to
claim it again. Just Press [ENTER].
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p 'Plex Server Claim Number | Press [ENTER]: ' typed </dev/tty
  echo $typed >/pg/var/plex.claim && break=on
}

# FUNCTIONS END ##############################################################

startfunction
#ansible-playbook /opt/coreapps/apps/plex.yml

################################################################################
ansible-playbook "/pg/apps/programs/${apps}/app.yml"
################################################################################
# ENDING CODE! If there is any code to execute before after deployment!

################################################################################
