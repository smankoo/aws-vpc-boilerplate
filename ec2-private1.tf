resource "aws_instance" "app1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.private1.id
  key_name = aws_key_pair.keypair4.key_name
  vpc_security_group_ids = [aws_security_group.allow_my_ssh.id, aws_security_group.web.id]
  iam_instance_profile = aws_iam_instance_profile.websource_read.name
  
  tags = {
    Name = "app1"
  }
}