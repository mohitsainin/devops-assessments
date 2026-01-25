aws_region        = "us-east-1"
availability_zone = "us-east-1a"

vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"

instance_type    = "t2.medium"
key_name         = "my-ec2-keypair"
allowed_ssh_cidr = "0.0.0.0/0"

ubuntu_ami_owner = "099720109477"
ubuntu_ami_name  = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

common_tags = {
  Name    = "Nexgensis"
  Project = "Nexgensis-api"
  Env     = "dev"
  Owner   = "devops"
}
