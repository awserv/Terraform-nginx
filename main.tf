#------------------------------
# Instance t2.micro
# nginx
# security group
# index.html
# lifecycle
#------------------------------



provider "aws" {
  access_key = ".........."
  secret_key = ".........."
   region = "eu-central-1"
}

resource "aws_instance" "my_webserver"{
ami = "ami-0f3a43fbf2d3899f7"
instance_type = "t2.micro"
vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

lifecycle {
create_before_destroy = true
}

user_data = <<E0F

#!/bin/bash
apt -y update
apt -y install nginx
echo "<h2>WebServer with IP: $myip</h2><br>One Terraform!"   > /var/www/html/index.html
sudo service nginx start
E0F

 tags = {
  Name = "terrs"
 }
}

resource "aws_security_group" "sec_group" {
  name = "group2"
  description = "second"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
   }
 }