aws_region = "us-east-1"
project_name = "fintech-aws-platform"
domain = "www.fintechaws.app.com"
hosted_zone_id = "Z1234567890ABCDEFGH"
azs = ["us-east-1a", "us-east-1b"]
db_name="fintechdb"
db_password_secret_name = "fintech/rds/password"
allowed_cidrs = [ "0.0.0.0/0" ]
//variables