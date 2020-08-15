/*
  All variables for VPC and EC2
*/

variable "region" {}

variable "aws_access_key" {
    type = "string"
    default = ""
} 
variable "aws_secret_key" {
    type = "string"
    default = "" 
} 
variable "aws_key_path" {
    type = "string"
    default = "" 
} 
variable "aws_key_name" {
    type = "string"
    default = ""
} 

variable "amis-ws1" {
    description = "Webserver1 AMI by region"
    type = map
    default = {  
        us-west-1 = "ami-05400f46392bcacd2" 
        ca-central-1 = "ami-002f142e41b90abe4" 
    }
}

variable "amis-ws2" {  
    description = "Webserver2 AMI by region"
    type = map
    default = {
        us-west-1 = "ami-095e1370588748297" 
        ca-central-1 = "ami-0e126ec84c97eb385" 
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

variable "instance_type" {
    description = "The type of instance to start"
    type = "string"
    default = "t2.micro"
}