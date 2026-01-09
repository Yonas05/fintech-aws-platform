output "alb_sg_id"             { value = aws_security_group.alb_sg.id }
output "ecs_sg_id"             { value = aws_security_group.ecs_sg.id }
output "ecr_frontend_url"      { value = aws_ecr_repository.frontend.repository_url }
output "ecr_api_url"           { value = aws_ecr_repository.api.repository_url }
output "db_password_secret_arn"{ value = data.aws_secretsmanager_secret.db_secret.arn }