resource "aws_instance" "this_aws_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc-security-group]
//[var.this_aws_instance_sg_id]
  availability_zone      = var.availability_zone
  subnet_id = var.subnet_id 
  root_block_device {
    volume_size = var.instance_volume_size
  }
  count = var.instance_count
  //user_data_base64 = var.this_aws_instance_user_data_base64
    user_data = <<-EOF
            #!/bin/bash
             sudo -i
             yum install nginx -y
             echo "Terraform User" > /usr/share/nginx/html/index.html
            systemctl start nginx
    EOF 

  tags = {
      
      Name =  var.instance_tags
  }
}