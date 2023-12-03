
#Create route table for public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.vpc-tf.id

  route {
    cidr_block = var.cidr
    gateway_id = aws_internet_gateway.internet-gateway-tf.id
  }

  tags = {
    Name = "tf-public-rtb"
    Tier = "public"
  }
}

#Create route table for private subnets
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.vpc-tf.id

  route {
    cidr_block     = var.cidr
    nat_gateway_id = aws_nat_gateway.nat-gateway-tf.id
  }

  tags = {
    Name = "tf-private-rtb"
    Tier = "private"
  }
}

resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.public-subnet-tf]
  for_each       = aws_subnet.public-subnet-tf
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private-subnet-tf]
  for_each       = aws_subnet.private-subnet-tf
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rtb.id
}