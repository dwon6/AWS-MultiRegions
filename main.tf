# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
}

/*
  CIDR Range for VPC
*/
resource "aws_vpc" "LB-VPC" {
    cidr_block = var.LB-VPC
    tags = {
      Name = "LB-VPC"
    }
}

/*
  subnet1 and subnet2 for ELB
*/
resource "aws_subnet" "LB-Subnet1" {
    vpc_id = aws_vpc.LB-VPC.id
    cidr_block = var.LB-Subnet1
    availability_zone = "us-west-1a"
    tags = {
      Name = "LB-subnet1"
    }
}
resource "aws_subnet" "LB-Subnet2" {
    vpc_id = aws_vpc.LB-VPC.id
    cidr_block = var.LB-Subnet2
    availability_zone = "us-west-1b"
    tags = {
      Name = "LB-Subnet2"
    }
}

/*
  subnet1 and subnet2 for Web Server
*/
resource "aws_subnet" "WS-Subnet1" {
    vpc_id = aws_vpc.LB-VPC.id
    cidr_block = var.WS-Subnet1
    availability_zone = "us-west-1a"
    tags = {
      Name = "WS-Subnet1"
    }
}

resource "aws_subnet" "WS-Subnet2" {
    vpc_id = aws_vpc.LB-VPC.id
    cidr_block = var.WS-Subnet2
    availability_zone = "us-west-1b"
    tags = {
      Name = "WS-Subnet2"
    }
}

/*
  Create Internet Gateway
*/
resource "aws_internet_gateway" "LB-IGW" {
    vpc_id = aws_vpc.LB-VPC.id
}

/*
  Create Route Tables
*/
resource "aws_route_table" "LB-RT-2-Int" {
    vpc_id = aws_vpc.LB-VPC.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.LB-IGW.id
    }
    tags = {
      Name = "LB-RT-2-Int"
    }
}

resource "aws_route_table_association" "LB-RT-ASS" {
    subnet_id = ["aws_subnet.LB_Subnet1.id","aws_subnet.LB_Subnet2.id"]
    route_table_id = aws_route_table.LB-RT-2-Int.id
}