data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
  name = var.aws_region
}

data "aws_ami" "base" {
  most_recent = true
  owners      = [126027368216]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
