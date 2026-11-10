variable "my_ip" {
  description = "IP público com acesso à EC2, em formato CIDR (ex: 203.0.113.10/32)"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o security group será criado (ex: vpc-0123456789abcdef0)"
  type        = string
}
