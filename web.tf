/*
  Web Servers
*/
resource "aws_security_group" "WS-SG" {
    name = "WS-SG"
    description = "Allow WEB/SSH connections."

    ingress { # Outbound
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { # Outbound
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.LB-VPC.id}"

    tags = {
        Name = "WS-SG"
    }
}

resource "aws_instance" "ws1" {
    ami = "${lookup(var.amis-ws1, var.aws_region)}"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    subnet_id = "${aws_subnet.WS-Subnet1.id}"
    vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]
    tags = {
        Name = "Web Server 1"
    }
}

resource "aws_instance" "ws2" {
    ami = "${lookup(var.amis-ws2, var.aws_region)}"
    availability_zone = "us-west-1b"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    subnet_id = "${aws_subnet.WS-Subnet2.id}"
    vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]
    tags = {
        Name = "Web Server 2"
    }
}

# Create a new load balancer
resource "aws_elb" "LB-WS" {
    name               = "LB-WS"
    subnets            = ["aws_subnet.LB-Subnet1.id","aws_subnet.LB-Subnet2.id"]
    security_groups    = [aws_security_group.WS-SG.id]
  
    listener {
        instance_port     = "80"
        instance_protocol = "http"
        lb_port           = "80"
        lb_protocol       = "http"
    }

    health_check {
        target              = "HTTP:80/index.html"
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
   }
    instances           = ["aws_instance.ws1.id", "aws_instance.ws2.id"]

    tags = {
        Name = "LB-WS"
    }
}
