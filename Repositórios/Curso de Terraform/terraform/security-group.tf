resource "aws_security_group" "liberar_ssh" {
  name        = "liberar_ssh"
  description = "Acessar SSH nesse treco"

  ingress {
    description      = "SSH nos bangs"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ips
  }

  tags = {
    Name = "SSH"
  }
}

resource "aws_security_group" "liberar_ssh_outraregiao" {
  provider = aws.us-east-2
  name        = "liberar_ssh_outraregiao"
  description = "Acessar SSH nesse treco"

  ingress {
    description      = "SSH nos bangs"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ips
  }

  tags = {
    Name = "SSH"
  }
}