
output "access_urls" {
  value = "${module.cloudant_service.access_urls}"
}
output "service_instance_name" {
  value = "${module.cloudant_service.ibm_service_instance.service.name}"
}
output "host" {
  value = "${module.cloudant_service.access_urls["host"]}"
}
output "port" {
  value = "${module.cloudant_service.access_urls["port"]}"
}
output "password" {
  value = "${module.cloudant_service.access_urls["password"]}"
}
output "url" {
  value = "${module.cloudant_service.access_urls["url"]}"
}
output "username" {
  value = "${module.cloudant_service.access_urls["username"]}"
}