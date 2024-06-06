provider "aws" {
  region  = "us-west-2"   # Oregon region
  access_key = "AKIAZI2LHE73QL"
  secret_key = "kVNiZSbW03escIrTUtkVhRY"
}

module "vpc" {
    source = "./VPC/"
    my-vpc-cidr = "10.0.0.0/16"
    vpc-name-tag = "my-vpc-tag"
    my-public-subnet-cidr = "10.0.1.0/24"
    avalibility-zone = "us-west-2a"
    map-ip-public = "true"
    my-public-subnet-tag = "my-public-subnet"
    my-private-subnet-cidr = "10.0.2.0/24"
    map-ip-private = "false"
    my-private-subnet-tag = "my-private-subnet"
    my-igw-tag = "my-igw"
    route-table-cidr = "0.0.0.0/0"
    my-route-table-tag = "default"
}

module "ec2" {
    source = "./EC-2/"
    instance_ami = "ami-0eb9d67c52f5c80e5"
    instance_type = "t2.micro"
    key_name = "soham"
    vpc-security-group = module.vpc.security_group_id
    availability_zone = "us-west-2a"
    subnet_id = module.vpc.subnet_id
    instance_volume_size = "8"
    instance_count = "1"
    instance_tags = "soham"
}