#####################################################################
##
##      Created 10/17/18 by admin. for nodejs_app
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "ucd" {
  username = "${var.ucd_user}"
  password       = "${var.ucd_password}"
  ucd_server_url = "${var.ucd_server_url}"
}

# Random string to use for environment and agent names
resource "random_pet" "env_id" {
}


##############################################################
# Install node.js agent
##############################################################
resource "null_resource" "install_nodejs_agent" {
  # Specify the ssh connection
  connection {
    host = "${var.vm_address}"
    type = "ssh"
    user = "${var.ssh_user}"
    password = "${var.ssh_user_password}"
  }
  provisioner "ucd" {
    agent_name      = "${var.nodejs_agent_name}"
    ucd_server_url  = "${var.ucd_server_url}"
    ucd_user        = "${var.ucd_user}"
    ucd_password    = "${var.ucd_password}"
  }
  provisioner "local-exec" {
    when = "destroy"
    command = <<EOT
      echo Going to delete an agent!
      curl -k -u ${var.ucd_user}:${var.ucd_password} ${var.ucd_server_url}/cli/agentCLI?agent=${var.nodejs_agent_name}  -X DELETE
      echo deleted an agent!
EOT
  }
}

resource "ucd_component_mapping" "nodejs_app" {
  component = "nodejs_sample"
  description = "nodejs_sample Component"
  parent_id = "${ucd_agent_mapping.nodejs_agent.id}"
}

resource "ucd_component_process_request" "nodejs_app" {
  component = "nodejs_sample"
  environment = "${ucd_environment.environment.id}"
  process = "deploy"
  resource = "${ucd_component_mapping.nodejs_app.id}"
  version = "LATEST"
}

resource "ucd_resource_tree" "resource_tree" {
  base_resource_group_name = "Base Resource for environment ${var.environment_name}-${random_pet.env_id.id}"
}

resource "ucd_environment" "environment" {
  name = "${var.environment_name}-${random_pet.env_id.id}"
  application = "Nodejs_APP"
  base_resource_group ="${ucd_resource_tree.resource_tree.id}"
  component_property {
      component = "nodejs_sample"
      name = "host"
      value = "${var.host}"  
      secure = false
  }
  component_property { 
      component = "nodejs_sample"
      name = "port"
      value = "${var.port}" 
      secure = false
  }
  component_property { 
      component = "nodejs_sample"
      name = "password"
      value = "${var.password}" 
      secure = true
  }
  component_property { 
      component = "nodejs_sample"
      name = "url"
      value = "${var.url}" 
      secure = false
  } 
  component_property { 
      component = "nodejs_sample"
      name = "username"
      value = "${var.username}" 
      secure = false
  } 
  component_property { 
      component = "nodejs_sample"
      name = "apikey"
      value = "${var.apikey}" 
      secure = false
  }
  component_property { 
      component = "nodejs_sample"
      name = "iam_apikey_description"
      value = "${var.iam_apikey_description}" 
      secure = true
  }
  component_property { 
      component = "nodejs_sample"
      name = "iam_apikey_name"
      value = "${var.iam_apikey_name}" 
      secure = true
  }
  component_property { 
      component = "nodejs_sample"
      name = "iam_role_crn"
      value = "${var.iam_role_crn}" 
      secure = false
  }
  component_property { 
      component = "nodejs_sample"
      name = "iam_serviceid_crn"
      value = "${var.iam_serviceid_crn}" 
      secure = false
  }
}

resource "ucd_agent_mapping" "nodejs_agent" {
  depends_on = [ "null_resource.install_nodejs_agent" ]
  description = "Agent to manage the node.js server"
  agent_name = "${var.nodejs_agent_name}"
  parent_id = "${ucd_resource_tree.resource_tree.id}"
}

