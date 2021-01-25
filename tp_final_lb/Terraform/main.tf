terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true 

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.tag_name 
  }
}

resource "aws_security_group" "global-test-LB"{
  name ="global-test-LB"
  description = "global test"
 
  ingress {
    description  = "SSH"
    from_port    = 22 
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description  = "Jenkins port"
    from_port    = 8080 
    to_port      = 8080
    protocol     = "tcp" 
    cidr_blocks  = ["0.0.0.0/0"]
  }

  ingress {
    description  = "serveur web"
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
     from_port   = 0 
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }
}


