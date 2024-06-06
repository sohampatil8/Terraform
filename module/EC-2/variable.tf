
variable "instance_ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "key_name" {
    type = string
}

variable "vpc-security-group" {
    type = string
}

variable "availability_zone" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "instance_volume_size" {
    type = string
}

variable "instance_count" {
    type = string
}

variable "instance_tags" {
    type = string
}