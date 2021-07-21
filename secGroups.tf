resource "aws_security_group" "publicSubnet" {
  name = "publicSubnet"
  description = "Rules for public subnet"
  vpc_id = aws_vpc.WebProd.id

  ingress {
      description = ""
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "secGroupPublicSubnet"
      "Terraform" = "True"
  }
  

}


resource "aws_security_group" "privateSubnet" {
  name = "privateSubnet"
  description = "Local rules for private subnet"
  vpc_id = aws_vpc.WebProd.id

   tags = {
      Name = "secGroupPublicSubnet"
      "Terraform" = "True"
  }

}