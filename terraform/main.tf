provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

data "aws_ami" "packer_image" {
  most_recent = true

  filter {
    name   = "tag:Created-by"
    values = ["Packer"]
  }

  filter {
    name   = "tag:Name"
    values = [var.app_name]
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
    cidr_blocks = var.allowed_ip
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

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-iam-role"

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action" = "sts:AssumeRole",
        "Effect" = "Allow",
        "Sid"    = "",
        "Principal" = {
          "Service" = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.jenkins_role.name
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "jenkins_ami" {
  ami                    = data.aws_ami.packer_image.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.jenkins_instance_profile.name
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id]

  tags = {
    "Name" = var.app_name
  }
}
