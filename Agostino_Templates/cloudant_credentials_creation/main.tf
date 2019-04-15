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
ibmcloud login -a https://cloud.ibm.com -r us-south
ibmcloud service key-create ${var.service_name} ${var.service_credentials_name}
script_output=$(ibmcloud service key-show ${var.service_name} ${var.service_credentials_name})
	EOF
    destination = "chmod +x /tmp/create_credentials.sh"
  }
  
provisioner "file" {
    when ="destroy"
    content = <<EOF
#!/bin/bash
#
export BLUEMIX_API_KEY=${var.bluemix_key}
ibmcloud login -a https://cloud.ibm.com -r us-south
ibmcloud service key-delete ${var.service_name} ${var.service_credentials_name}
	EOF
    destination = "chmod +x /tmp/delete_credentials.sh"
  }
 
 }
 
resource "camc_scriptpackage" "CreateScript" {
  program = ["/bin/bash", "/tmp/create_credentials.sh"]
  depends_on = ["null_resource.ibmcli_vm"]
  on_create = true
}

resource "camc_scriptpackage" "DestroyScript" {
  program = ["/bin/bash", "/tmp/delete_credentials.sh"]
  depends_on = ["null_resource.ibmcli_vm"]
  on_delete = true
} 
