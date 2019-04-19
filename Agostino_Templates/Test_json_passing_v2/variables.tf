#####################################################################
##
##      Created 10/17/18 by admin. for nodejs_app
##
#####################################################################

variable "vm_address" {
  description = "The IPv4 address of virtual machine where the application will be installed"
}

variable "ssh_user" {
  description = "The user for ssh connection, which is default in template"
  default     = "root"
}

variable "ssh_user_password" {
  description = "The user password for ssh connection, which is default in template"
}

variable "cloudant_cred" {
  description = "cloudant credentials"
}

