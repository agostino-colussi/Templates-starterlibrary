#####################################################################
##
##      Created 10/17/18 by admin. for credentials_creation
##
#####################################################################



provider "null" {
  version = "~> 0.1"
}

# Random string to use for app_name
resource "random_pet" "app_name" {
}

resource "null_resource" "credentials_vm" {
  connection {
    host = "${var.vm_address}"
    type = "ssh"
    user = "${var.ssh_user}"
    password = "${var.ssh_user_password}"
    }

	provisioner "file" {
    content = <<EOF
#!/bin/bash
#    Set Bluemix API Key and login to IBM Cloud
#    Create credentials for Cloudant service
#    Gather the ten credential's variables
#
 export BLUEMIX_API_KEY=VpBEADM3vPaz148kG6xKy70wdD8LTzonPNppVleP0a5h
 ibmcloud login -a https://api.ng.bluemix.net
 ibmcloud resource service-key-create creds_for_agostino Manager --instance-name Cloudant-dr > credentials.txt
 file="./credentials.txt"
 app_name="app-${random_pet.app_name.id}"
 username=$(grep "username:" "$file" | sed -n 's/username://p' )
 apikey=$(grep "apikey:" "$file" | sed -n 's/apikey://p' )
 host=$(grep "host:" "$file" | sed -n 's/host://p' )
 iam_role_crn=$(grep "iam_role_crn:" "$file" | sed -n 's/iam_role_crn://p' )
 iam_serviceid_crn=$(grep "iam_serviceid_crn:" "$file" | sed -n 's/iam_serviceid_crn://p' )
 url=$(grep "url:" "$file" | sed -n 's/url://p' )
 iam_apikey_description=$(grep "iam_apikey_description:" "$file" | sed -n 's/iam_apikey_description://p' )
 iam_apikey_name=$(grep "iam_apikey_name:" "$file" | sed -n 's/iam_apikey_name://p' )
 password=$(grep "password:" "$file" | sed -n 's/password://p' )
 port=$(grep "port:" "$file" | sed -n 's/port://p' )
	EOF
    destination = "/tmp/credentials.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/credentials.sh; bash /tmp/credentials.sh",      
    ]
  } 
  
 } 
 








