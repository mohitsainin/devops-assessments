output "instance_id" {
  value       = aws_instance.nexgensis_api.id
  description = "EC2 Instance ID"
}

output "public_ip" {
  value       = aws_instance.nexgensis_api.public_ip
  description = "Public IP of Nexgensis EC2"
}

output "vpc_id" {
  value       = aws_vpc.nexgensis.id
  description = "VPC ID"
}
