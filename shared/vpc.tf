/*
  VPC for whole network
*/
resource "aws_vpc" "LB-VPC" {
    cidr_block = "${var.LB-VPC}"
    tags = {
      Name = "LB-VPC"
    }
}

/*
  Public subnets - ELB
*/
resource "aws_subnet" "LB-Subnet1" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
    cidr_block = "${var.LB-Subnet1}"
    availability_zone = "${var.region}a"
    tags = {
      Name = "LB-subnet1"
    }
}
resource "aws_subnet" "LB-Subnet2" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
    cidr_block = "${var.LB-Subnet2}"
    availability_zone = "${var.region}b"
    tags = {
      Name = "LB-Subnet2"
    }
}

/*
  Private subnets - WebServers
*/
resource "aws_subnet" "WS-Subnet1" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
    cidr_block = "${var.WS-Subnet1}"
    availability_zone = "${var.region}a"
    tags = {
      Name = "WS-Subnet1"
    }
}

resource "aws_subnet" "WS-Subnet2" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
    cidr_block = "${var.WS-Subnet2}"
    availability_zone = "${var.region}b"
    tags = {
      Name = "WS-Subnet2"
    }
}

/*
  Internet Gateway to VPC
*/
resource "aws_internet_gateway" "LB-IGW" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
}

/*
  Route Tables and associate with Public subnets
*/
resource "aws_route_table" "LB-RT-2-Int" {
    vpc_id = "${aws_vpc.LB-VPC.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.LB-IGW.id}"
    }
    tags = {
      Name = "LB-RT-2-Int"
    }
}

resource "aws_route_table_association" "LB-RT-ASS1" {
    subnet_id = "${aws_subnet.LB-Subnet1.id}"
    route_table_id = "${aws_route_table.LB-RT-2-Int.id}"
}
resource "aws_route_table_association" "LB-RT-ASS2" {
    subnet_id = "${aws_subnet.LB-Subnet2.id}"
    route_table_id = "${aws_route_table.LB-RT-2-Int.id}"
}