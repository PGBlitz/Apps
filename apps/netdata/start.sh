#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# DO NOT CHANGE OR DELETE!
source /pg/apps/functions.sh
common
################################################################################
# STARTER CODE! If there is any code to execute before role deployment!

################################################################################
ansible-playbook "/pg/apps/apps/${apps}/app.yml"
################################################################################
# STARTER CODE! If there is any code to execute before after deployment!

################################################################################
