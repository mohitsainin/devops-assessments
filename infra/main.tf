# --------------------
# VPC
# --------------------
resource "aws_vpc" "nexgensis" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.common_tags
}

# --------------------
# Internet Gateway
# --------------------
resource "aws_internet_gateway" "nexgensis_igw" {
  vpc_id = aws_vpc.nexgensis.id
  tags   = var.common_tags
}

# --------------------
# Public Subnet
# --------------------
resource "aws_subnet" "nexgensis_public" {
  vpc_id                  = aws_vpc.nexgensis.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags                    = var.common_tags
}

# --------------------
# Route Table
# --------------------
resource "aws_route_table" "nexgensis_public_rt" {
  vpc_id = aws_vpc.nexgensis.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nexgensis_igw.id
  }

  tags = var.common_tags
}

resource "aws_route_table_association" "nexgensis_public_assoc" {
  subnet_id      = aws_subnet.nexgensis_public.id
  route_table_id = aws_route_table.nexgensis_public_rt.id
}

# --------------------
# Security Group
# --------------------
resource "aws_security_group" "nexgensis_sg" {
  name   = "nexgensis-sg"
  vpc_id = aws_vpc.nexgensis.id
  tags   = var.common_tags

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --------------------
# Ubuntu AMI (Dynamic)
# --------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ubuntu_ami_owner]

  filter {
    name   = "name"
    values = [var.ubuntu_ami_name]
  }
}

# --------------------
# EC2 Instance
# --------------------
resource "aws_instance" "nexgensis_api" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.nexgensis_public.id
  vpc_security_group_ids = [aws_security_group.nexgensis_sg.id]
  tags                   = var.common_tags
}
