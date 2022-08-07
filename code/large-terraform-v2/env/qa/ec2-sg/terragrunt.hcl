terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v4.9.0//."
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name                = "ec2-sg"
  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_rules = ["all-all"]
  vpc_id        = dependency.vpc.outputs.vpc_id
  egress_rules  = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "all-all"
      cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
    },
  ]
}
