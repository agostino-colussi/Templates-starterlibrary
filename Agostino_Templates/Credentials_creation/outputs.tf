#########################################################
# Output
#########################################################
output "credentials" {
  value = "${remote-exec.stdout}"
}

/*
output "app_name" {
  value = "${null_resource.credentials_vm.app_name}"
}

output "username" {
  value = "${null_resource.credentials_vm.username}"
}

output "apikey" {
  value = "${null_resource.credentials_vm.apikey}"
}

output "host" {
  value = "${null_resource.credentials_vm.host}"
}

output "iam_role_crn" {
  value = "${null_resource.credentials_vm.iam_role_crn}"
}

output "iam_serviceid_crn" {
  value = "${null_resource.credentials_vm.iam_serviceid_crn}"
}

output "url" {
  value = "${null_resource.credentials_vm.url}"
}

output "iam_apikey_description" {
  value = "${null_resource.credentials_vm.iam_apikey_description}"
}

output "iam_apikey_name" {
  value = "${null_resource.credentials_vm.iam_apikey_name}"
}

output "password" {
  value = "${null_resource.credentials_vm.password}"
}

output "port" {
  value = "${null_resource.credentials_vm.port}"
}
*/
