variable "aws_region" {
  type        = string
  description = "AWS region to create the infrastructure"
  default     = "eu-west-1"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet cidr block"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet cidr block"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}

variable "instance_tenancy" {
    type = string
    description = "Tenancy of instances spin up within VPC"
  default = "default"
}

variable "dns_support" {
    type = string
    description = "Whether or not the VPC has DNS support - defaults to true"
  default = true
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
  default = "teleport-poc"
}

variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
  default = "10.0.0.0/16"
}

variable "s3_bucket_name" {
  type = string
  description = "Bucket name for cluster storage"
  default = "teleport.calvineotieno.com"
}
