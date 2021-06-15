provider "aws" {
        region = "${var.region}"      
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
}
resource "aws_instance" "WebServer" {
    ami = "${var.ami}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    security_groups = ["Apache"]
   

tags = {
    Name = "Apache web Server"
    Owner = "Oleksii Martyniuk"
    Project = "Final Project"
 }
}
output "pub_ips" {
    value = aws_instance.WebServer.public_ip
    
}
