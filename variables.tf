variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "amis_ws1" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-0ac6bde51a7ef9cc6" # Webserver1
    }
}

variable "amis_ws2" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-055cc014370a6acb4" # Webserver2
    }
}

variable "LB_VPC" {
    description = "LB_VPC"
    default = "10.0.0.0/16"
}

variable "LB_Subnet1" {
    description = "LB_Subnet1"
    default = "10.0.0.0/24"
}

variable "LB_Subnet2" {
    description = "LB_Subnet2"
    default = "10.0.1.0/24"
}

variable "WS_Subnet1" {
    description = "WS_Subnet1"
    default = "10.0.2.0/24"
}

variable "WS_Subnet2" {
    description = "WS_Subnet2"
    default = "10.0.3.0/24"
}
