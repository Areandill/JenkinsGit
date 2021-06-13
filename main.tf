provider "aws" { region = "eu-central-1" }

resource "aws_instance" "WebServer" {
    ami = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"
    security_groups = ["Apache"]
    
    provisioner "local-exec" {
    command = "echo ${aws_instance.app_server.public_ip} >> output.tf"
    }
tags = {
    Name = "WebServer"
    Owner = "Oleksii Martyniuk"
    Project = "Final Project"
  }
}
