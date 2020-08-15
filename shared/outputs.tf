output "lb_address" {
  value = "${aws_elb.LB-WS.dns_name}"
}