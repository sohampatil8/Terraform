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