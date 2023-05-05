resource "aws_security_group" "cluster" {
   name = "${var.name_prefix}-cluster"
   description = "${var.name_prefix} cluster"
   vpc_id = module.vpc.vpc_id


  tags = {
    TeleportCluster = "${var.name_prefix}-${var.cluster_name}"
  }
  
}

resource "aws_security_group_rule" "cluster_ingress_ssh" {
  description       = "Permit inbound to SSH"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] // Chnage this to allow only from known host/VPN
  security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group_rule" "cluster_ingress_services" {
  description       = "Permit inbound to Teleport services"
  type              = "ingress"
  from_port         = 3022
  to_port           = 3025
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group_rule" "cluster_egress" {
  description       = "Permit all outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group" "proxy_acm" {
  name        = "${var.name_prefix}-proxy-acm"
  description = "Proxy SG for application LB (ACM)"
  vpc_id      = module.vpc.vpc_id
  tags = {
    TeleportCluster = "${var.name_prefix}-${var.cluster_name}"
  }
}

resource "aws_lb_target_group" "proxy_proxy" {
    name     = "${var.name_prefix}-proxy-proxy"
  port     = 3023
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}

resource "aws_lb_target_group" "proxy_tunnel_acm" {
  name     = "${var.name_prefix}-proxy-tunnel"
  port     = 3024
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}

resource "aws_lb_target_group" "proxy_kube" {
  name     = "${var.name_prefix}-proxy-kube"
  port     = 3026
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}

resource "aws_lb_target_group" "proxy_mysql" {
  name     = "${var.name_prefix}-proxy-mysql"
  port     = 3036
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}

resource "aws_lb_target_group" "proxy_postgres" {
  name     = "${var.name_prefix}-proxy-postgres"
  port     = 5432
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}

resource "aws_lb_target_group" "proxy_mongodb" {
  name     = "${var.name_prefix}-proxy-mongodb"
  port     = 27017
  vpc_id   = module.vpc.vpc_id
  protocol = "TCP"
}
