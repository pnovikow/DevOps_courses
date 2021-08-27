provider "aws" {
  access_key = "AKIAY2PRH2WWGDYDTRFR"
  secret_key = "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"
  region     = "us-east-2"
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t3.micro"
}

resource "aws_security_group" "Ubuntu" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
