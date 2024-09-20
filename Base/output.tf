# Output the public IP of the EC2 instance
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

# Output the VPC ID
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.my_vpc.id
}

# Output the VPC CIDR Block
output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value       = aws_vpc.my_vpc.cidr_block
}
