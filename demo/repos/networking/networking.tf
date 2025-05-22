#vpc, subnet, sg for web, sg for ssh
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-demo-vpc"
  }
}

###  SUBNET  ###
resource "aws_subnet" "demo" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.prefix}-demo-subnet"
  }
}

###  SECURITY GROUPS  ###
# HTTP:
resource "aws_security_group" "allow_web_traffic" {
  name        = "${var.prefix}-allow_web_traffic"
  description = "Allow inbound web traffic and all outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "allow_web" {
  security_group_id = aws_security_group.allow_web_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.port
  ip_protocol       = "tcp"
  to_port           = var.port
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_web_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_egress" {
  security_group_id = aws_security_group.allow_web_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}