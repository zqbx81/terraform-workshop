provider "aws" {
  region = var.region
  #  profile = var.profile
  allowed_account_ids = var.allowed_account_ids
}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  azs         = ["ap-southeast-1a", "ap-southeast-1b"]
  cidr_blocks = ["172.16.10.0/24", "172.16.50.0/24"]
  ports       = ["80", "443", "22"]
}

// 网络
resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "tf-demo-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count                   = length(local.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.cidr_blocks[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${count.index}"
  }
}

data "aws_route_table" "table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tf-demo-ec2-gw"
  }
}

resource "aws_route" "r" {
  route_table_id         = data.aws_route_table.table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

// 安全组
resource "aws_security_group" "allow" {
  name        = "allow"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ports
    content {
      description      = "${ingress.value} from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow"
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet.0.id
  vpc_security_group_ids = [aws_security_group.allow.id]
  user_data              = templatefile("${path.module}/init.sh", { content = "hello terraform" })
  tags = {
    Name = "web"
  }
}
