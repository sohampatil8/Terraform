
resource "aws_instance" "tf-instance" {
  ami           = "ami-0eb9d67c52f5c80e5"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key-tf.id}"    //public_key
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]   //security_group
  tags = {
    Name = "tf_instance"
  }
  user_data = file("${path.module}/script.sh")
  connection {
        type = "ssh" 
        user = "ec2-user"
        private_key = file("./id_rsa")  //#chmod 600 id_rsa (permission)
        host = "${self.public_ip}"
  }
  
  provisioner "file" {
    source = "id_rsa"
    destination = "/tmp/id_rsa" 
  }
  
  provisioner "file" {
    content = "Hey mannnnn! whatsapp..."
    destination = "/tmp/terraform" 
  }
  
}