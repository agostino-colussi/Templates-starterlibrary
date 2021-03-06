####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################

provider "null" {
  version = "~> 0.1"
}

resource "null_resource" "ibmcli_vm" {
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
export BLUEMIX_API_KEY=${var.bluemix_key}
ibmcloud config --check-version=false > /tmp/create_cloudant_credentials.log 2>&1
ibmcloud login -a https://cloud.ibm.com -r us-south >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud target --cf-api https://api.us-south.cf.cloud.ibm.com -o agostino.colussi -s Test >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud service key-create ${var.service_name} ${var.service_credentials_name} >> /tmp/create_cloudant_credentials.log 2>&1
com_response=$(ibmcloud service key-show ${var.service_name} ${var.service_credentials_name})

apikey_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.apikey')
host_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.host')
iam_apikey_description_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.iam_apikey_description')
iam_apikey_name_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.iam_apikey_name')
iam_serviceid_crn_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.iam_serviceid_crn')
password_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.password')
port_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.port')
url_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.url')
username_var=$(echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' | jq '.username')

return_result="{\"apikey\": $apikey_var, \"host\": $host_var, \"iam_apikey_description\": $iam_apikey_description_var, \"iam_apikey_name\": $iam_apikey_name_var, \"iam_serviceid_crn\": $iam_serviceid_crn_var, \"password\": $password_var, \"port\": $port_var, \"url\": $url_var, \"username\": $username_var}"
echo $return_result
EOF
    destination = "/tmp/create_credentials.sh"
  }
  
provisioner "file" {
    content = <<EOF
#!/bin/bash
#
export BLUEMIX_API_KEY=${var.bluemix_key}
ibmcloud config --check-version=false >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud login -a https://cloud.ibm.com -r us-south >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud target --cf-api https://api.us-south.cf.cloud.ibm.com -o agostino.colussi -s Test >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud service key-delete ${var.service_name} ${var.service_credentials_name} -f >> /tmp/create_cloudant_credentials.log 2>&1
EOF
    destination = "/tmp/delete_credentials.sh"
  }
 
 }
 
resource "camc_scriptpackage" "CreateScript" {
  program = ["/bin/bash", "/tmp/create_credentials.sh"]
  depends_on = ["null_resource.ibmcli_vm"]
  remote_host = "${var.vm_address}"
  remote_user = "${var.ssh_user}"
  remote_password = "${var.ssh_user_password}"
  on_create = true
}

resource "camc_scriptpackage" "DestroyScript" {
  program = ["/bin/bash", "/tmp/delete_credentials.sh"]
  depends_on = ["null_resource.ibmcli_vm"]
  remote_host = "${var.vm_address}"
  remote_user = "${var.ssh_user}"
  remote_password = "${var.ssh_user_password}"
  on_delete = true
} 
