# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

##############################################################
# Script package to install WebSphere Application
##############################################################


resource "camc_scriptpackage" "RemoteScript1" {
  program = ["/usr/bin/tar xvf /tmp/deployApp.tar -C /tmp"]
  remote_host = "${var.ip_address}"
  remote_user = "${var.user}"
  remote_password = "${var.password}"
  remote_key = "${var.private_key}"
  destination = "/tmp/deployApp.tar"
  source = "${path.module}/scripts/deployApp.tar"
  on_create = true
}

resource "camc_scriptpackage" "RemoteScript2" {
  depends_on = ["camc_scriptpackage.RemoteScript1"]
  program = ["su - ${var.was_user} -c \"${var.was_install_profile_dir}/bin/wsadmin.sh -profile /tmp/wsadminlib.py -f /tmp/deployApp.py ${var.app_uri} ${var.target_type} ${var.node_name}Node01:${var.target_name}  ${var.application_name} 1>&2\""]
  remote_host = "${var.ip_address}"
  remote_user = "${var.user}"
  remote_password = "${var.password}"
  remote_key = "${var.private_key}"
  destination = "/tmp/deployApp.tar"
  source = "${path.module}/scripts/deployApp.tar"
  on_create = true
}


