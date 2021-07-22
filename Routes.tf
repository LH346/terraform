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

resource "aws_route_table_association" "pub01" {
  subnet_id      = aws_subnet.pubWebProd01.id
  route_table_id = aws_route_table.publicRTwebProd.id
}

resource "aws_route_table_association" "pub02" {
  subnet_id      = aws_subnet.pubWebProd02.ids
  route_table_id = aws_route_table.publicRTwebProd.id
}

resource "aws_route_table" "privateRTwebProd" {
  
  vpc_id = aws_vpc.WebProd.id

  tags = {
    "Name" = "privateRTprod"
    "Terraform" = "True"
  }

}