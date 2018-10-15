# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

##############################################################
# CHAINED INPUT VARIABLES
##############################################################

variable "ip_address" { type = "string" description = "IP Address of the HOST to install the APM Agent." }
variable "user" { type = "string" description = "Userid to install the APM Agent, root reccomended." default = "root" }
variable "password" { type = "string" description = "Password of the installation user." }
variable "private_key" { type = "string" description = "Private key of the installation user. This value should be base64 encoded"}

##############################################################
# COMMAND VARIABLES
##############################################################

variable "was_install_profile_dir" { type = "string" description = "Directory of the profile which houses the AdminApp" default = "/opt/IBM/WebSphere/AppServer/profiles/AppSrv01" }
variable "was_user" { type = "string" description = "The WebSphere Admin User" default = "wasadmin" }
variable "app_uri" { type = "string" description = "URI Location of the EAR or WAR file" default = "http://IPADDRESS:8888/WebcontainerSample.ear" }
variable "target_type" { type = "string" description = "Target type, eg, cluster or server" default = "server" }
variable "node_name" { type = "string" description = "Name of the node for the target server, only applicable for a server install" default = "" }
variable "target_name" { type = "string" description = "Name of the cluster or server" default = "server1" }
variable "application_name" { type = "string" description = "Name of the application" default = "WebcontainerSample" }
