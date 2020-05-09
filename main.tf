#------------------------------
# Instance t2.micro
# nginx
# security group
#------------------------------



provider "aws" {
  access_key = ".........."
  secret_key = ".........."
   region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
ami = " ami-0e342d72b12109f91"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.my_webserver.id]
user_data = file("user_data.sh")
 }


resource "aws_security_group" "my_webserver" {
  name        = "Server Security Group"
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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