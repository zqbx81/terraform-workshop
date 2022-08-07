terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v4.1.0//."
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../aws-data", "../vpc", "../ec2-sg"]
}

dependency "aws-data" {
  config_path = "../aws-data"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "ec2-sg" {
  config_path = "../ec2-sg"
}

inputs = {
  name                   = "web"
  ami                    = dependency.aws-data.outputs.ubuntu_20_04_aws_ami_id
  instance_type          = "t2.micro"
  availability_zone      = element(dependency.aws-data.outputs.available_aws_availability_zones_names, 0)
  subnet_id              = element(dependency.vpc.outputs.public_subnets, 0)
  vpc_security_group_ids = [dependency.ec2-sg.outputs.security_group_id]
}
