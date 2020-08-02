variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "amis-ws1" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-05400f46392bcacd2" # Webserver1
    }
}

variable "amis-ws2" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-095e1370588748297" # Webserver2
    }
}

variable "LB-VPC" {
    description = "LB-VPC"
    default = "10.0.0.0/16"
}

variable "LB-Subnet1" {
    description = "LB-Subnet1"
    default = "10.0.0.0/24"
}

variable "LB-Subnet2" {
    description = "LB-Subnet2"
    default = "10.0.1.0/24"
}

variable "WS-Subnet1" {
    description = "WS-Subnet1"
    default = "10.0.2.0/24"
}

variable "WS-Subnet2" {
    description = "WS-Subnet2"
    default = "10.0.3.0/24"
}