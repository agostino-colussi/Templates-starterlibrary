module "wasdeploy" {
  source = "./modules/wasdeploy"

  ip_address = "${var.ip_address}"
  user = "${var.user}"
  password = "${var.password}"
  private_key = "${var.private_key}"
  app_uri = "${var.app_uri}"
  was_install_profile_dir = "${var.was_install_profile_dir}"
  was_user = "${var.was_user}"
  target_type = "${var.target_type}"
  node_name = "${var.node_name}"
  target_name = "${var.target_name}"
  application_name = "${var.application_name}"
}
