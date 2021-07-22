


resource "aws_vpc" "WebProd" {

  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "WebProd"
    "Terraform" = "True"
  }
}

resource "aws_subnet" "pubWebProd01" {
  
  vpc_id                  = aws_vpc.WebProd.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "pubWebProd"
    "Terraform" = "True"
  }

}

resource "aws_subnet" "pubWebProd02" {
  
  vpc_id                  = aws_vpc.WebProd.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "pubWebProd"
    "Terraform" = "True"
  }

}

resource "aws_subnet" "privateWebProd01" {
  
  vpc_id                  = aws_vpc.WebProd.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "privateWebProd"
    "Terraform" = "True"
  }

}

resource "aws_subnet" "privateWebProd02" {
  
  vpc_id                  = aws_vpc.WebProd.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "privateWebProd"
    "Terraform" = "True"
  }

}


resource "aws_internet_gateway" "natPublicWebProd" {
  vpc_id = aws_vpc.WebProd.id

  tags = {
    "Name" = "natPublicWebProd"
    "Terraform" = "True"
  }
  
}

