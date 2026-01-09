resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "ALB ingress from internet, egress to ECS"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.project_name}-alb-sg" }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "ECS tasks accept traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "ALB to ECS"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.project_name}-ecs-sg" }
}

resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-frontend"
  image_scanning_configuration { scan_on_push = true }
}

resource "aws_ecr_repository" "api" {
  name = "${var.project_name}-api"
  image_scanning_configuration { scan_on_push = true }
}

data "aws_secretsmanager_secret" "db_secret" {
  name = var.db_password_secret_name
}