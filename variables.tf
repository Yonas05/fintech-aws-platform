
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "fintech-aws-platform"

}
variable "domain" {
  description = "The domain name for the project"
  type        = string
  default     = "www.fintechaws.app.com"

}
variable "hosted_zone_id" {

  type = string
}
variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

}
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "db_engine" {
  type    = string
  default = "prostgres"

}
variable "db_instance_class" {
  type    = string
  default = "db.t4.medium"
}
variable "db_name" {
  type    = string
  default = "fintechdb"

}
variable "db_username" {
  type    = string
  default = "fintechuser"

}
variable "db_password_secret_name" {

  type    = string
  default = "fintech/rds/password"

}
variable "allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}
