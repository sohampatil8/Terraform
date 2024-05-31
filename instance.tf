# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"   # Oregon region
}

resource "aws_instance" "example_server" {
  ami           = "ami-0eb9d67c52f5c80e5"
  instance_type = "t2.micro"
  tags = {
    Name = "soham_instance"
  }
}

resource "aws_vpc" "example" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "my-subnet"
  }
}