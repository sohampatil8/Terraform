provider "aws" {
  region  = "us-west-2"   # Oregon region
  access_key = var.access_key
  secret_key = var.secret_key
}

 resource "aws_key_pair" "key-tf" {
   key_name   = "my-key"
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

resource "aws_instance" "tf-instance" {
  ami           = "ami-0eb9d67c52f5c80e5"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key-tf.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "tf_instance"
  }
}