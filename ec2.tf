resource "aws_instance" "website_server" {
  ami                    = "ami-052b3645c2c811821" #Amazon Linux 2 AMI
  instance_type          = "t3.micro"
  key_name               = "edilson-key"
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile   = "ECR-EC2-ROLE1"


  tags = {
    Name        = "website_server"
    Provisioned = "Terraform"
    Cliente     = "Edilson"
  }
}

## Security Group
resource "aws_security_group" "website_sg" {
  name   = "website_sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "website_sg"
    Provisioned = "Terraform"
    Cliente     = "Edilson"

  }
}
##Regras de entrada para o Security Group
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = var.my_ip
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = var.my_ip
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "website_server" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = var.my_ip
  ip_protocol = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_https_outbound" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}