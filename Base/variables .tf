# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnet 1 CIDR block
variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

# Public Subnet 2 CIDR block
variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "ssh_access_cidr" {
  description = "CIDR block that allows SSH access (e.g., your IP address)"
  type        = string
  default     = "223.185.28.117/32"  
}


variable "ssh_key_path" {
  description = "The full path to your SSH public key"
  type        = string
  default     = "C:/Users/91877/.ssh/id_rsa.pub"
}

