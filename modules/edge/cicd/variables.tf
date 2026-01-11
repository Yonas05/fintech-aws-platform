variable "aws_region"        { type = string }
variable "suffix"            { type = string } // random suffix for S3 uniqueness
variable "github_owner"      { type = string }
variable "github_repo"       { type = string }
variable "github_branch"     {
  type    = string
  default = "main"
}
variable "github_oauth_token"{ 
    type = string 
    sensitive = true 
    }
variable "github_repo_url"   { type = string }
variable "ecr_frontend_url"  { type = string }
variable "ecr_api_url"       { type = string }
variable "cluster_name"      { type = string }
variable "service_frontend"  { type = string }
variable "service_api"       { type = string }