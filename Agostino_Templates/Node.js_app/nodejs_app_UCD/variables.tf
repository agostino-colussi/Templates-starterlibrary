#####################################################################
##
##      Created 10/17/18 by admin. for nodejs_app
##
#####################################################################

variable "ucd_user" {
  type = "string"
  description = "UCD User."
  default = "admin"
}

variable "ucd_password" {
  type = "string"
  description = "UCD Password."
  default = ""
}

variable "ucd_server_url" {
  type = "string"
  description = "UCD Server URL"
}

variable "environment_name" {
  type = "string"
  description = "Generated"
}

variable "nodejs_agent_name" {
  type = "string"
  description = "agent name"
}

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

variable "host" {
  description = "service host"
}

variable "port" {
  description = "service port"
}

variable "password" {
  description = "service password"
}

variable "url" {
  description = "service url"
}

variable "username" {
  description = "service username"
}

variable "apikey" {
  description = "service apikey"
}

variable "iam_apikey_description" {
  description = "service iam_apikey_description"
}

variable "iam_apikey_name" {
  description = "service iam_apikey_name"
}

variable "iam_role_crn" {
  description = "service iam_role_crn"
}

variable "iam_serviceid_crn" {
  description = "service iam_serviceid_crn"
}