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

  ingress {
      description = ""
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    description = ""
    from_port = 0
    to_port   = 0
    protocol  = "-1"
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

  ingress {
      description = ""
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = ""
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
   tags = {
      Name = "secGroupPrivateSubnet"
      "Terraform" = "True"
  }

}