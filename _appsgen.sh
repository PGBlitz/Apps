#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
appslistgen () {

# Generates App List
ls -la /pg/apps/apps/ | sed -e 's/.yml//g' \
| awk '{print $9}' | tail -n +4  > /pg/var/app.list

# Enter Items Here to Prevent them From Showing Up on AppList
sed -i -e "/watchtower/d" /pg/var/app.list
sed -i -e "/pgui/d" /pg/var/app.list

}
