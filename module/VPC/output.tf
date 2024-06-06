output "subnet_id" {
  value = aws_subnet.public-subnet.id
}
output "vpc_id" {
  value = aws_vpc.my-vpc.id
}
output "security_group_id" {
  value = aws_security_group.this_sg.id
}