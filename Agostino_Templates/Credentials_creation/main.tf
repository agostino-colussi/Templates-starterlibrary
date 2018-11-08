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
 ibmcloud login -a https://api.ng.bluemix.net > /tmp/login.txt
 app_name="app-${random_pet.app_name.id}" 
 echo "app_name: " $app_name > /tmp/credential.txt
 echo " " >> /tmp/credential.txt
 ibmcloud resource service-key-create creds_for_$app_name Manager --instance-name Cloudant-dr > credentials-tmp.txt
 file="./credentials-tmp.txt"
 username=$(grep "username:" "$file" | sed -n 's/username://p' )
 echo "username: "$username >> /tmp/credential.txt
 apikey=$(grep "apikey:" "$file" | sed -n 's/apikey://p' )
 echo "apikey: "$apikey >> /tmp/credential.txt
 host=$(grep "host:" "$file" | sed -n 's/host://p' )
 echo "host: "$host >> /tmp/credential.txt
 iam_role_crn=$(grep "iam_role_crn:" "$file" | sed -n 's/iam_role_crn://p' )
 echo "iam_role_crn: "$iam_role_crn >> /tmp/credential.txt
 iam_serviceid_crn=$(grep "iam_serviceid_crn:" "$file" | sed -n 's/iam_serviceid_crn://p' )
 echo "iam_serviceid_crn: "$iam_serviceid_crn >> /tmp/credential.txt
 url=$(grep "url:" "$file" | sed -n 's/url://p' )
 echo "url: "$url >> /tmp/credential.txt
 iam_apikey_description=$(grep "iam_apikey_description:" "$file" | sed -n 's/iam_apikey_description://p' )
 echo "iam_apikey_description: "$iam_apikey_description >> /tmp/credential.txt
 iam_apikey_name=$(grep "iam_apikey_name:" "$file" | sed -n 's/iam_apikey_name://p' )
 echo "iam_apikey_name: "$iam_apikey_name >> /tmp/credential.txt
 password=$(grep "password:" "$file" | sed -n 's/password://p' )
 echo "password: "$password >> /tmp/credential.txt
 port=$(grep "port:" "$file" | sed -n 's/port://p' )
 echo "port: "$port >> /tmp/credential.txt
	EOF
    destination = "/tmp/credentials.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/credentials.sh; bash /tmp/credentials.sh",      
    ]
  }

 } 

resource "null_resource" "local_vm" {

 provisioner "local-exec" {
    command = <<CMD
      rm -rf /tmp/crendentials.txt \
        && apt update \
		    && apt install sshpass \
        && sshpass -p "${var.ssh_user_password}" scp -r ${var.ssh_user}@${var.vm_address}:/tmp/crendentials.txt crendentials.txt
    CMD
   }
 }
 








