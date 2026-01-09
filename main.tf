module "vpc" {
    source = "./modules/vpc"
    project_name=var.project_name
    vpc_cidr=var.vpc_cidr
    azs=var.azs      
    public_subnet_cidrs=var.public_subnet_cidrs
    private_subnet_cidrs=var.private_subnet_cidrs
    
}
module "security"{
    source = "./modules/security"
    project_name=var.project_name
    vpc_id=module.vpc.vpc_id
    allowed_cidrs=var.allowed_cidrs
    db_password_secret_name=var.db_password_secret_name
}























module "alb" {
    source = "./modules/alb"
    project_name=var.project_name
    vpc_id=module.vpc.vpc_id
    public_subnet_ids=module.vpc.public_subnet_ids
    alb_sg_id=module.security.alb_sg_id
    alb_cert_arn=module.edge.alb_cert_arn
  
}
module "rds"{
    source = "./modules/rds"
    project_name=var.project_name
    vpc_id=module.vpc.vpc_id
    private_subnet_ids=module.vpc.private_subnet_ids
    ecs_sg_id=module.security.ecs_sg_id
    db_engine=var.db_engine
    db_instance_class=var.db_instance_class
    db_name=var.db_name
    db_username=var.db_username
    db_password_secret_name=var.db_password_secret_name
}

module "ecs" {
    source = "./modules/ecs"
    aws_region=var.aws_region
    project_name=var.project_name
    private_subnet_ids=module.vpc.private_subnet_ids
    ecs_sg_id=module.security.ecs_sg_id
    frontend_tg_arn=module.alb.frontend_tg_arn
    frontend_image=module.security.ecr.frontend_url
    api_image=module.security.ecr_api_url
    api_base_url="https://app.${var.domain_name}"
    db_host=module.rds.db_host
    db_name=var.db_name
    db_username=var.db_username
    db_password_secret_arn=module.security.db_password_secret_arn


 
}
module "cicd" {
  source            = "./modules/cicd"
  aws_region        = var.aws_region
  suffix            = "12345"  // change to a random suffix
  github_owner      = "your-github-user"
  github_repo       = "aws-fintech-infra"
  github_branch     = "main"
  github_oauth_token= "REPLACE_WITH_TOKEN"
  github_repo_url   = "https://github.com/your-github-user/aws-fintech-infra"
  ecr_frontend_url  = module.security.ecr_frontend_url
  ecr_api_url       = module.security.ecr_api_url
  cluster_name      = module.ecs.cluster_name
  service_frontend  = module.ecs.frontend_service_name
  service_api       = module.ecs.api_service_name
}

module "edge" {
  source         = "./modules/edge"
  project_name   = var.project_name
  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  alb_dns_name   = module.alb.alb_dns_name
}