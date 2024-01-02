output "public_ip" {
  value = aws_instance.jenkins_ami.public_ip
}

output "public_dns" {
  value = aws_instance.jenkins_ami.public_dns
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_ami.public_dns}:8080"
}
