data "aws_ami" "ubuntu-xenial" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20180912"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "dev" {
  ami           = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t2.micro"

  tags {
    Name = "dev"
  }
}

resource "aws_eip" "dev" {
  instance = "${aws_instance.dev.id}"
  vpc      = true
}
