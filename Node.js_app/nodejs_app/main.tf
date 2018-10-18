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
#    Install git if not present
#    Clone the git repository where the Sample Node.js application code is residing (https://github.com/IBM-Cloud/nodejs-cloudant)
#    Create vcap-local.json file that includes the value for the VCAP_SERVICES environment variable
#    Run npm install to install the application's dependencies
#    Install forever tool 
#    Start the application using forever tool
#
yum install git -y
cd /tmp
git clone https://github.com/IBM-Cloud/nodejs-cloudant
cd ./nodejs-cloudant
touch vcap-local.json
chown root:root vcap-local.json
chmod 755 vcap-local.json
row="{\"cloudantNoSQLDB\":[{ \"credentials\": { \"apikey\": \"${var.apikey}\", \"host\": \"${var.host}\", \"iam_apikey_description\": \"${var.iam_apikey_description}\", \"iam_apikey_name\": \"${var.iam_apikey_name}\", \"iam_role_crn\": \"${var.iam_role_crn}\", \"iam_serviceid_crn\": \"${var.iam_serviceid_crn}\", \"password\": \"${var.password}\", \"port\": ${var.port}, \"url\": \"${var.url}\", \"username\": \"${var.username}\" }}]}"
echo "$row" >> vcap-local.json
npm install
npm install forever --global
forever start app.js
	EOF
    destination = "/tmp/deploy_app.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/deploy_app.sh; bash /tmp/deploy_app.sh",      
    ]
  } 
  
 } 