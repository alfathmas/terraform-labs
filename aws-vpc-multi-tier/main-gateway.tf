resource "aws_internet_gateway" "igw-tf" {
  vpc_id = aws_vpc.vpc-tf.id

  tags = {
    Name = "tf-igw"
  }
}

resource "aws_eip" "nat-gw-eip-tf" {
  vpc         = true
  depends_on  = [aws_internet_gateway.igw-tf]

  tags = {
    Name = "tf-nat-eip"
  }
}

resource "aws_nat_gateway" "nat-gw-tf" {
  depends_on    = [aws_subnet.public-subnet-tf]
  allocation_id = aws_eip.nat-gw-eip-tf.id
  subnet_id     = aws_subnet.public-subnet-tf["public-subnet-1"].id

  tags = {
    Name = "tf-nat-gw"
  }
}
