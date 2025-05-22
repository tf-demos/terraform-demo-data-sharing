data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.small"
  security_groups = [data.tfe_outputs.networking.nonsensitive_values["vm_security_group"]]

  user_data = templatefile("boot.sh", {
    app_name = "${var.prefix}-app",
    port     = var.port
  })

  tags = {
    Name = "${var.prefix}-terramino"
  }
}