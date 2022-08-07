module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 3.0"
  name                   = "web"
  ami                    = module.aws-data.outputs.ubuntu_20_04_aws_ami_id
  instance_type          = "t2.micro"
  availability_zone      = element(module.vpc.azs, 0)
  subnet_id              = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = templatefile("${path.module}/init.sh", { content = "hello terraform" })
}
