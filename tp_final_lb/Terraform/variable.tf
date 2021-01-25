variable "region" {
  type = string
  description = "AWS region"
  default = "eu-west-3"
}

variable "instance_type" {
  type = string
  description = "instance type"
  default = "t2.micro"
}


variable "tag_name" {
  type = string
  description = "tag name"
  default = "instance_Jenkins_serveur_Loup_Bruneau"
}





