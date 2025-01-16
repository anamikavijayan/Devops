provider "aws" {
  region = "ap-south-1"  # Update to your desired AWS region
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # You can change this CIDR block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-private-vpc-anamika"
  }
}
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # Adjust subnet size if needed
  availability_zone       = "ap-south-1a"   # Update with your desired availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1"
  }
}
