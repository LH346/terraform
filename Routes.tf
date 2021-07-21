resource "aws_route_table" "publicRTwebProd" {
  vpc_id = aws_vpc.WebProd.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.natPublicWebProd.id
  }

  tags = {
    "Name" = "publicRTprod"
    "Terraform" = "True"
  }
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.pubWebProd.id
  route_table_id = aws_route_table.publicRTwebProd.id

  tags = {
    "Name" = "publicRTprod"
    "Terraform" = "True"
  }
}

resource "aws_route_table" "privateRTwebProd" {
  
  vpc_id = aws_vpc.WebProd.id

  tags = {
    "Name" = "privateRTprod"
    "Terraform" = "True"
  }

}