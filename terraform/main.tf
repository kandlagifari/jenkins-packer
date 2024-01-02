provider "aws" {
  region = var.region
}

data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "tag:Created-by"
    values = ["Packer"]
  }

  filter {
    name   = "tag:Name"
    values = [var.appname]
  }

  owners = ["self"]
}

resource "aws_security_group" "allow_jenkins" {
  name        = "allow_jenkins"
  description = "Allow inbound traffic to jenkins 8080"

  ingress {
    description = "Jenkins Inbound Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_jenkins"
  }
}

resource "aws_instance" "jenkins_ami" {
  ami                    = data.aws_ami.packer_image.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id]

  tags = {
    "Name" = var.appname
  }
}
