#####################################################################
##
##      Created 10/17/18 by admin. for nodejs_app
##
#####################################################################



provider "null" {
  version = "~> 0.1"
}

resource "null_resource" "app_vm" {
  connection {
    host = "${var.vm_address}"
    type = "ssh"
    user = "${var.ssh_user}"
    password = "${var.ssh_user_password}"
    }

	provisioner "file" {
    content = <<EOF
#!/bin/bash
#    
#
cd /tmp
mkdir test_json
cd ./test_json
touch vcap-local.json
chown root:root vcap-local.json
chmod 755 vcap-local.json
row="${ length(var.cloudant_cred) > 0 ? base64decode(var.cloudant_cred) : var.cloudant_cred}"
echo "$row" >> vcap-local.json
	EOF
    destination = "/tmp/create_json.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/create_json.sh; bash /tmp/create_json.sh",      
    ]
  } 
  
 } 