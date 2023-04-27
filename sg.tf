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
