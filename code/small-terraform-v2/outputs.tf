# output "ec2_public_ip" {
#   value = join(" ", tolist(["ssh", join("", tolist(["ubuntu@", aws_instance.saltmaster.public_ip])), "-i", local_sensitive_file.ssh_key.filename]))
# }
