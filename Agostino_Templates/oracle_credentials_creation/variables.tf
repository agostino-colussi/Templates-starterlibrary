#####################################################################
##
##      Created 3/29/19 by Ago for oracle_credentials_creation
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
  default = "passw0rd"
}

variable "oracle_user" {
  description = "The Oracle user name"
}

variable "oracle_user_pwd" {
  description = "The Oracle user password"
}