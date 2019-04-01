#####################################################################
##
##      Created 3/29/19 by Ago for oracle_credentials_creation
##
#####################################################################

provider "null" {
  version = "~> 0.1"
}

resource "null_resource" "oracle_vm" {
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
su - oracle -c "sqlplus system/passw0rd << !
grant create session, create table, create procedure,
      create sequence, create view, create trigger,
      create synonym, create materialized view, query rewrite,
      create any directory, create type,dba, aq_administrator_role
to ${var.oracle_user} identified by ${var.oracle_user_pwd};
!"
	EOF
    destination = "/tmp/create_user.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/create_user.sh; bash /tmp/create_user.sh",      
    ]
  } 
  
 } 