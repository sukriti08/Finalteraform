# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Sukriti"
  }
}

# two public subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "PublicSubnetSukriti1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "PublicSubnetSukriti2"
  }
}

#  Internet Gateway for VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associattting subnets with route table
resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group for EC2 instance (allowing HTTP and SSH access)
resource "aws_security_group" "allow_http_ssh" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]  # Only allow SSH from your IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "AllowHTTPandSSH"
  }
}

# Key Pair for EC2 Instance
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file(var.ssh_key_path)  # Using the variable for the public key
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-04505e74c0741db8d"  # Ubuntu 20.04 AMI for us-east-1 (adjust for your region)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  
  #  public IP assignment
  associate_public_ip_address = true

  tags = {
    Name = "Sukriti"
  }
}

