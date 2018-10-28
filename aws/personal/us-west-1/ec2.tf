data "aws_ami" "ubuntu-xenial" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-2018*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "personal-key" {
  key_name   = "personal-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4d+UeovLqusyXmoAMUfDFg7eosw1DqGIzUglmJf31DBRyY3Rfl+LdR5jQTrpzuMdYYW1hRiKhehf+qyGan+hMep8/nTK8cf0YbqZXHIkOBSBmRHjih46gd4zSK86MBm3JvI1dQEXs+ReZXDfKz9d5sPr9h4RnDW5RqTJdWKq6BZtK7dlNrQk7XLUHfAVu+mZVUuHVtK0xyq4NitpZt2F1nppCaumX37by0Vvt1gcRDuTcAyLRrhCvwEucb0iK5rZwuChvyFZOo+P3rYRpu+pkgkckXqmj05sXANgCvCH/zwpk3ivMAbiok1gFGjMR3hjCA5I2yvdQb+Ws23czyvo9C2rDhy93gnciNgIShHSebE7FynVrs7vV25yHBokACFbjDJiWEekbuu3XlADxgx7RW2clbjWwyCuZPYGFjgs9HRoKEujloFeutL9sbknXxq6WXtxkmpIuN1J3c3EAnwWCcEfWhFTCoEz901t/oSYD/W3ij1s4nZuFzEYrNVxVIsLt6GnewiFACeUt957xmNjN8AjX46CvSYF1MlR6Q18jT56MzmhNGZNOYc7kfq0K+qFQ+MCoxBKzaVzFFW4Hc9n5CHh7q9qkPUZAoSw9TRKNrfZ7Ib0Valfxdb/n5EUVepTMiUzifjEj/WD/p+aSKbUPTOjsJARf5ne0DXz70mxPvQ== danielpops@Daniels-MacBook-Pro.local"
}

data "aws_security_group" "default" {
    name = "default"
}

resource "aws_instance" "dev" {
  ami           = "${data.aws_ami.ubuntu-xenial.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.personal-key.key_name}"

  vpc_security_group_ids = ["${data.aws_security_group.default.id}"]

  root_block_device = {
      volume_size=30 # gb
  }

  tags {
    Name = "dev"
  }
}

resource "aws_eip" "dev" {
  instance = "${aws_instance.dev.id}"
  vpc      = true
}
