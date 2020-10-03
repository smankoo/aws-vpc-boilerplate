data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.public1.id
  key_name = aws_key_pair.keypair2.key_name
  vpc_security_group_ids = [aws_security_group.allow_my_ssh.id, aws_security_group.web.id]
  iam_instance_profile = aws_iam_instance_profile.websource_read_profile.name

  
  tags = {
    Name = "web1"
  }
}