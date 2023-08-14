module "security_group" {
  source       = "terraform-aws-modules/security-group/aws"
  version      = "~> 4.0"
  name         = var.sg_name
  description  = "Security group for example usage with EC2 instance"
  vpc_id       = module.vpc.vpc_id
  egress_rules = ["all-all"]
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
    }
  ]
}
