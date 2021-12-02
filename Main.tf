# My VPC
resource "aws_vpc" "Project5-VPC" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Project5-VPC"
  }
}

# My Private-SN1
resource "aws_subnet" "Priv-SN1" {
  vpc_id     = aws_vpc.Project5-VPC.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Priv-SN1"
  }
}

# My Private-SN2
resource "aws_subnet" "Priv-SN2" {
  vpc_id     = aws_vpc.Project5-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Priv-SN2"
  }
}


# My Public-SN1
resource "aws_subnet" "Pub-SN1" {
  vpc_id     = aws_vpc.Project5-VPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Pub-SN1"
  }
}

# My Public-SN2
resource "aws_subnet" "Pub-SN2" {
  vpc_id     = aws_vpc.Project5-VPC.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Pub-SN2"
  }
}

# My Private Route Table

resource "aws_route_table" "Priv-RT" {
  vpc_id = aws_vpc.Project5-VPC.id

  route = []

  tags = {
    Name = "Priv-RT"
  }
}

# My Public Route Table

resource "aws_route_table" "Pub-RT" {
  vpc_id = aws_vpc.Project5-VPC.id

  route = []

  tags = {
    Name = "Pub-RT"
  }
}

# Private RT Association with private SN
resource "aws_route_table_association" "PrivRT-PrivSN1" {
  subnet_id      = aws_subnet.Priv-SN1.id
  route_table_id = aws_route_table.Priv-RT.id
}

resource "aws_route_table_association" "PrivRT-PrivSN2" {
  subnet_id      = aws_subnet.Priv-SN2.id
  route_table_id = aws_route_table.Priv-RT.id
}



# Public RT Association with Public SN

resource "aws_route_table_association" "PubRT-PubSN1" {
  subnet_id      = aws_subnet.Pub-SN1.id
  route_table_id = aws_route_table.Pub-RT.id
}

resource "aws_route_table_association" "PubRT-PubSN2" {
  subnet_id      = aws_subnet.Pub-SN2.id
  route_table_id = aws_route_table.Pub-RT.id
}

# Internet Gateway
resource "aws_internet_gateway" "Project5-IGW" {
  vpc_id = aws_vpc.Project5-VPC.id

  tags = {
    Name = "Project5-IGW"
  }
}
# IGW association with Pub-RT

resource "aws_route" "IGW-ass-pub-RT" {
  route_table_id            = aws_route_table.Pub-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Project5-IGW.id
 
}

# Nat Gateway

resource "aws_nat_gateway" "Project5-NGW" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.Priv-SN1.id
}
