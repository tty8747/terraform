variable "aws-region" {
  default = "eu-west-2"
  description = "Default region"
}

variable "ami" {
  default = "ami-06d954f8e6d94f918"
  description = "Region"
}

variable "insttype" {
  default = "t2.micro"
  description = "Type instance"
}

variable "domainname" {
# default = "srwx.net."
  default = "ubukubu.ru."
  description = "Name domain"
}

variable "keypath" {
  default = "/home/goto/.ssh/id_rsa.pub"
  description = "path to pub key"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.16.0.0/16"
}

variable "vpc_cidr_public" {
    description = "CIDR for the Public subnet"
    default = "172.16.0.0/24"
}

variable "vpc_cidr_private" {
    description = "CIDR for the Private subnet"
    default = "172.16.1.0/24"
}
