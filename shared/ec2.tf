/*
  Security Group for ELB and WebServers
*/
resource "aws_security_group" "LB-SG" {
    name = "LB-SG"
    description = "Security Group for LB."

    ingress { # Inbound
        from_port = 80
        to_port = 80
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
        Name = "LB-SG"
    }
}

resource "aws_security_group" "WS-SG" {
    name = "WS-SG"
    description = "Security Group for WB."

    ingress { # Inbound
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.LB-SG.id}"]
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

/*
  EC2 for WebServer2
*/
resource "aws_instance" "ws1" {
    ami = "${lookup(var.amis-ws1, var.region)}"
    availability_zone = "${var.region}a"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}" 
    subnet_id = "${aws_subnet.WS-Subnet1.id}"
    vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]
    tags = {
        Name = "Web Server 1"
    }
}

resource "aws_instance" "ws2" {
    ami = "${lookup(var.amis-ws2, var.region)}"
    availability_zone = "${var.region}b"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}" 
    subnet_id = "${aws_subnet.WS-Subnet2.id}"
    vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]
    tags = {
        Name = "Web Server 2"
    }
}

/*
  ELB for WebServers
*/
resource "aws_elb" "LB-WS" {
    name               = "LB-WS"
    subnets            = ["${aws_subnet.LB-Subnet1.id}","${aws_subnet.LB-Subnet2.id}"]
    security_groups    = ["${aws_security_group.LB-SG.id}"]
  
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
    instances           = ["${aws_instance.ws1.id}", "${aws_instance.ws2.id}"]

    tags = {
        Name = "LB-WS"
    }
}