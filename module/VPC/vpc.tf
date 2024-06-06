resource "aws_vpc" "my-vpc" {
  cidr_block       = var.my-vpc-cidr  // my-vpc
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name-tag   // tag-vpc
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-public-subnet-cidr  // my-public-subnet
  availability_zone = var.avalibility-zone    // my-availibility-zone
  map_public_ip_on_launch = var.map-ip-public // map-public-ip

  tags = {
    Name = var.my-public-subnet-tag   // my-subnet-tag
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.my-private-subnet-cidr  // my-private-subnet
  availability_zone = var.avalibility-zone    // my-availibility-zone
  map_public_ip_on_launch = var.map-ip-private // map-private-ip

  tags = {
    Name = var.my-private-subnet-tag   // my-subnet-tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.my-igw-tag     // my-internet-gtw
  }
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = var.route-table-cidr  // cidr-route-table
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.my-route-table-tag     // my-rt_table-tag
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_security_group" "this_sg" {
  vpc_id = aws_vpc.my-vpc.id
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