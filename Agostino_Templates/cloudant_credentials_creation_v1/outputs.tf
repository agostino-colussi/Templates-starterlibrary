#####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################

output "cloudant_credentials" {
  value = "${camc_scriptpackage.CreateScript.result}"
}

output "apikey" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "apikey")}"
}
  
output "host" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "host")}"
}
  
output "iam_apikey_description" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "iam_apikey_description")}"
}
  
output "iam_apikey_name" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "iam_apikey_name")}"
}
  
output "iam_serviceid_crn" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "iam_serviceid_crn")}"
}
  
output "password" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "password")}"
}
  
output "port" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "port")}"
}
  
output "url" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "url")}"
}
  
output "username" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "username")}"
} 

