variable "project_name"           { type = string }
variable "vpc_id"                 { type = string }
variable "allowed_cidrs"          { type = list(string) }
variable "db_password_secret_name"{ type = string }