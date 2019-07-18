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

# Generates App List From Core Apps
ls -la /pg/apps/programs/ | sed -e 's/.yml//g' \
| awk '{print $9}' | tail -n +4 > /pg/var/app.list

# Exemption List to Prevent WatchTower from Adding
sed -i -e "/traefik/d" /pg/var/app.list
sed -i -e "/image*/d" /pg/var/app.list
sed -i -e "/_appsgen.sh/d" /pg/var/app.list
sed -i -e "/_c*/d" /pg/var/app.list
sed -i -e "/_a*/d" /pg/var/app.list
sed -i -e "/_t*/d" /pg/var/app.list
sed -i -e "/templates/d" /pg/var/app.list
sed -i -e "/retry/d" /pg/var/app.list
sed -i "/^test\b/Id" /pg/var/app.list
sed -i -e "/nzbthrottle/d" /pg/var/app.list
sed -i -e "/watchtower/d" /pg/var/app.list
sed -i "/^_templates.yml\b/Id" /pg/var/app.list
sed -i -e "/oauth/d" /pg/var/app.list
sed -i -e "/dockergc/d" /pg/var/app.list
sed -i -e "/pgui/d" /pg/var/app.list

while read p; do
  echo -n $p >> /pg/tmp/watchtower.set
  echo -n " " >> /pg/tmp/watchtower.set
done </pg/var/app.list
################################################################################
ansible-playbook "/pg/apps/programs/${apps}/app.yml"
################################################################################
# ENDING CODE! If there is any code to execute before after deployment!

################################################################################
