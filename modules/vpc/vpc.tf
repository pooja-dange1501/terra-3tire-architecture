resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_subnet" "websubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "appsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "eu-north-1b"
}

resource "aws_subnet" "dbsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.32.0/20"
  availability_zone = "eu-north-1c"
}

# NAT
resource "aws_eip" "nat-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.websubnet.id
}

# ROUTES
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route" "nat-route" {
  route_table_id         = aws_route_table.pvt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# ASSOCIATIONS
resource "aws_route_table_association" "web" {
  subnet_id      = aws_subnet.websubnet.id
  route_table_id = aws_route_table.pub.id
}

resource "aws_route_table_association" "app" {
  subnet_id      = aws_subnet.appsubnet.id
  route_table_id = aws_route_table.pvt.id
}

resource "aws_route_table_association" "db" {
  subnet_id      = aws_subnet.dbsubnet.id
  route_table_id = aws_route_table.pvt.id
}