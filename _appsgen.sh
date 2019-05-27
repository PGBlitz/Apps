#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Generates App List
ls -la /pg/apps/apps/ | sed -e 's/.yml//g' \
| awk '{print $9}' | tail -n +4  > /pg/var/app.list

ls -la /opt/mycontainers/ | sed -e 's/.yml//g' \
| awk '{print $9}' | tail -n +4  >> /pg/var/app.list
# Enter Items Here to Prevent them From Showing Up on AppList
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
