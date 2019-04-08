#####################################################################
##
##      Created 4/8/19 by camuser2@localtest.com.
##
#####################################################################

output "public_ip" {
  value = "${aws_instance.orpheus_ubuntu_micro.public_ip}"
}
