/*
  Web Servers
*/
resource "aws_security_group" "WS_SG" {
    name = "WS_SG"
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

    vpc_id = "${aws_vpc.LB_VPC.id}"

    tags = {
       Name = "WS_SG"
    }
}

resource "aws_instance" "ws1" {
    ami = "${lookup(var.amis_ws1, var.aws_region)}"
    availability_zone = "us-west-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
//    network_id = "${aws_vpc.LB_VPC.id}"
    subnet_id = "${aws_subnet.WS_Subnet1.id}"
    vpc_security_group_ids = ["${aws_security_group.WS_SG.id}"]
//    tags {
//         Name = "Web Server 1"
//    }
}

resource "aws_instance" "ws2" {
    ami = "${lookup(var.amis_ws2, var.aws_region)}"
    availability_zone = "us-west-1b"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
//    network_id = "${aws_vpc.LB_VPC.id}"
    subnet_id = "${aws_subnet.WS_Subnet2.id}"
    vpc_security_group_ids = ["${aws_security_group.WS_SG.id}"]
//    tags {
//         Name = "Web Server 2"
//    }
}

# Create a new load balancer
//resource "aws_elb" "LB-WS" {
//  name               = "LB-WS"
//  vpc_id             = "${aws_vpc.LB_VPC.id}"
//  security_groups    = [aws_security_group.WS_SG.id]
//  subnets            = ["aws_subnet.LB_Subnet1.id","aws_subnet.LB_Subnet2.id"]
  
//  listener {
//    instance_port     = "80"
//    instance_protocol = "http"
//    lb_port           = "80"
//    lb_protocol       = "http"
//  }

// health_check {
//    target              = "HTTP:80/index.html"
//    interval            = 30
//    healthy_threshold   = 2
//    unhealthy_threshold = 2
//    timeout             = 5
//  }

// ELB attachments
//    number_of_instances = 2
//    instances           = ["aws_instance.ws1.id", "aws_instance.ws2.id"]

//    tags = {
//    Name = "LB-WS"
//    }
//}

resource "aws_lb_target_group" "LB-WS" {
    health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "LB-WS"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${aws_vpc.LB_VPC.id}"
  instances   = ["aws_instance.ws1.id", "aws_instance.ws2.id"]
}
