provider "aws" {
  region  = "us-west-2"   # Oregon region
}

 resource "aws_key_pair" "key-tf" {
   key_name   = "terraform_key"
   public_key = file("${path.module}/id_rsa.pub")
 }

resource "aws_security_group" "allow_tls" {
  name        = "security-tf"
  description = "Allow TLS inbound traffic and all outbound traffic"
  
  dynamic "ingress" {
    for_each = [80, 8080, 443, 53, 22, 3306]
    iterator = port
    content {
            from_port        = port.value
            to_port          = port.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
    }
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
