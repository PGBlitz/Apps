#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# DO NOT CHANGE OR DELETE!
app="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
app="$( echo "$app" | cut -d'/' -f5- )"
echo $app > /pg/var/role.name
################################################################################
# STARTER CODE! If there is any code to execute before role deployment!

################################################################################
ansible-playbook /pg/apps/${app}/app.yml
################################################################################
# STARTER CODE! If there is any code to execute before after deployment!

################################################################################
