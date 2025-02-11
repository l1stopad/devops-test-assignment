variable "aws_region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR блок для VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR блок для публічної підмережі"
  default     = "10.0.1.0/24"
}
