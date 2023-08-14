output "web_url" {
  value = join("", tolist(["http://", module.ec2.public_ip]))
}
