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

variable "front_open_nginx" {
  type        = "list"
  default     = ["80","443"]
}
