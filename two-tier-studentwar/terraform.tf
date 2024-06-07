resource "aws_instance" "tf-instance" {
  ami           = "ami-0d0d929a80abaf672"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key-tf.id}"    //public_key
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]   //security_group
  tags = {
    Name = "tf_instance"
  }
    //[var.this_aws_instance_sg_id]
  availability_zone      = "us-west-2a"

  connection {
        type = "ssh" 
        user = "ec2-user"
        private_key = file("./id_rsa")  //#chmod 600 id_rsa (permission)
        host = "${self.public_ip}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo ./apache-tomcat/bin/catalina.sh start"
    ]
  }
}
