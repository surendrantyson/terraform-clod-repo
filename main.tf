# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh-port-open" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-http-port-open" {
  name        = "vpc-web"
  description = "Dev VPC Web"

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance
resource "aws_instance" "terraform-ec2-1" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type[2]
  count                  = var.ec2_instance_count
  user_data              = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to GreensTechnology ! AWS Infra created using Terraform in ap-south-1 Region</h1>" > /var/www/html/index.html
    EOF
  vpc_security_group_ids = [aws_security_group.vpc-http-port-open.id , aws_security_group.vpc-ssh-port-open.id]
  tags = {
    "Name" = "myec2vm"
  }
}

# Create RDS MySQL Database
resource "aws_db_instance" "msql-bd-terraform" {
  allocated_storage   = 5
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  name                = "mydb1"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}

# Resource Block to Create VPC in us-east-1 which uses default provider
resource "aws_vpc" "vpc-mumbai-suren" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "vpc-us-east-1"
  }
}

resource "aws_vpc" "vpc-ohio-suren" {
  cidr_block = "10.1.0.0/16"
  provider   = aws.ohio
  tags = {
    "Name" = "vpc-us-west-1"
  }
}
