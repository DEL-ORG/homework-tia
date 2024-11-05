# Specify your variables
variable "instance_type" {
  default = "t2.micro"  # Free tier eligible, change if needed
}

variable "ami" {
  default = "ami-06b21ccaeff8cd686"  # Amazon Linux 2 AMI in us-west-2 (check AMI ID in your region)
}

variable "key_name" {
  default = "s7"  # Replace with your key pair name
}

# Create an EC2 instance
resource "aws_instance" "homework01" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  # Security group allowing inbound SSH access
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "MyEC2Instance"
  }
}

# Security Group allowing SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}