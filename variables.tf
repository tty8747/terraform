variable "aws-region" {
  default     = "us-east-2"
  description = "Default region"
}

variable "ami" {
  default     = "ami-0f65671a86f061fcd"
  description = "Region"
}

variable "insttype" {
  default     = "t2.micro"
  description = "Type instance"
}

variable "domainname" {
  type        = "list"
  default     = ["ubukubu.ru.","aaaj.ru."]
}

variable "keypath" {
  default     = "~/.ssh/id_rsa.pub"
  description = "path to pub key"
}

variable "ssh_port" {
  type        = "list"
  default     = ["22"]
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
