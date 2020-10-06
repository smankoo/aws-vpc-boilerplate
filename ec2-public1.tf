resource "aws_instance" "web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  associate_public_ip_address = true

  subnet_id = aws_subnet.public1.id
  key_name = aws_key_pair.keypair4.key_name
  vpc_security_group_ids = [aws_security_group.allow_my_ssh.id, aws_security_group.web.id]
  iam_instance_profile = aws_iam_instance_profile.websource_read.name

  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
  
  tags = {
    Name = "web1"
  }
}

output "instance_public_ip_addr" {
  value = aws_instance.web1.public_ip
}
