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
  subnet_id      = aws_subnet.pubWebProd02.id
  route_table_id = aws_route_table.publicRTwebProd.id
}

resource "aws_route_table_association" "private01" {
  subnet_id = aws_subnet.privateWebProd01.id
  route_table_id = aws_route_table.privateRTwebProd.id
}

resource "aws_route_table_association" "private02" {
  subnet_id = aws_subnet.privateWebProd02.id  
  route_table_id = aws_route_table.privateRTwebProd.id
}

resource "aws_route_table" "privateRTwebProd" {
  
  vpc_id = aws_vpc.WebProd.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat01.id
  }
 // route {
   //   cidr_block = "0.0.0.0/0"
     // gateway_id = aws_nat_gateway.nat02.id
  //}

  tags = {
    "Name" = "privateRTprod"
    "Terraform" = "True"
  }
  
}