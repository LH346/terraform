resource "aws_instance" "bastion" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pubWebProd02.id
  vpc_security_group_ids = [aws_security_group.publicSubnet.id]
  //key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    user        = "ec2-user"
  }
  tags = {
    "Name" = "Bastion"
    "Terraform" = "True"
  }
}
