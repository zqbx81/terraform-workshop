output "web_url" {
  value = join("", tolist(["http://", aws_instance.web.public_ip]))
}
