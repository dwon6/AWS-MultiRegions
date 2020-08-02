# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
  access_key    = var.aws_access_key
  secret_key    = var.aws_secret_key
}

/*
  CIDR Range for VPC
*/
resource "aws_vpc" "LB_VPC" {
    cidr_block = var.LB_VPC
    tags = {
          Name = "LB_VPC"
    }
}

/*
  subnet1 and subnet2 for ELB
*/
resource "aws_subnet" "LB_Subnet1" {
    vpc_id = aws_vpc.LB_VPC.id
    cidr_block = var.LB_Subnet1
    availability_zone = "us-west-1a"
    tags = {
          Name = "LB_subnet1"
    }
}
resource "aws_subnet" "LB_Subnet2" {
    vpc_id = aws_vpc.LB_VPC.id
    cidr_block = var.LB_Subnet2
    availability_zone = "us-west-1b"
    tags = {
          Name = "LB_Subnet2"
    }
}

/*
  subnet1 and subnet2 for Web Server
*/
resource "aws_subnet" "WS_Subnet1" {
    vpc_id = aws_vpc.LB_VPC.id
    cidr_block = var.WS_Subnet1
    availability_zone = "us-west-1a"
    tags = {
          Name = "WS_Subnet1"
    }
}

resource "aws_subnet" "WS_Subnet2" {
    vpc_id = aws_vpc.LB_VPC.id
    cidr_block = var.WS_Subnet2
    availability_zone = "us-west-1b"
    tags = {
          Name = "WS_Subnet2"
    }
}

/*
  Create Internet Gateway
*/
resource "aws_internet_gateway" "LB_IGW" {
    vpc_id = aws_vpc.LB_VPC.id
}

/*
  Create Route Tables
*/
resource "aws_route_table" "LB_VPC_RT_2_Internet" {
    vpc_id = aws_vpc.LB_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.LB_IGW.id
    }
    tags = {
         Name = "LB_VPC_RT_2_Internet"
    }
}

resource "aws_route_table_association" "LB_VPC_RT_2_Internet1" {
    subnet_id = aws_subnet.LB_Subnet1.id
    route_table_id = aws_route_table.LB_VPC_RT_2_Internet.id
}
resource "aws_route_table_association" "LB_VPC_RT_2_Internet2" {
    subnet_id = aws_subnet.LB_Subnet2.id
    route_table_id = aws_route_table.LB_VPC_RT_2_Internet.id
}
